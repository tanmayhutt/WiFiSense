#include <ESP8266WiFi.h>

// ============================================
// WiFi-Based Human Presence Detection
// ULTRA ACCURATE with Advanced Signal Processing
// ============================================

const char* ssid = "YOUR_SSID";
const char* password = "YOUR_PASSWORD";

const int LED_PIN = 2;

// ========== ADVANCED KALMAN FILTER ==========
float kalmanGain = 0.15;
float estimate = -55;
float estimateError = 1;
float measurementError = 0.3;

// ========== EXTENDED SLIDING WINDOWS ==========
const int WINDOW_SIZE = 40;
const int LONG_WINDOW = 100;
float rssiWindow[WINDOW_SIZE];
float rssiLongWindow[LONG_WINDOW];
int windowIndex = 0;
int longWindowIndex = 0;

// ========== EXPONENTIAL SMOOTHING ==========
float smoothedRSSI = -55;
float smoothAlpha = 0.15;

// ========== BASELINE & ADAPTIVE THRESHOLDS ==========
float baseline = -55;
float baselineVariance = 1.0;
float adaptiveAlpha = 0.008;
float adaptiveBeta = 0.005;

// ========== DUAL THRESHOLD SYSTEM ==========
float slowMovementThreshold = 1.8;
float fastMovementThreshold = 3.5;
float zScoreThreshold = 2.5;

int disturbanceCounter = 0;
int persistenceRequired = 3;

// ========== DETECTION FEATURES ==========
int totalDetections = 0;
unsigned long lastDetectionTime = 0;
unsigned long sessionStartTime = 0;

String currentMotionIntensity = "CALM";
int confidenceScore = 0;

// ========== SIGNAL QUALITY METRICS ==========
float signalQuality = 0;
float rateOfChange = 0;
bool signalStable = true;

// ==========================================
// ADVANCED KALMAN FILTER
// ==========================================
float kalmanFilter(float measurement) {
  float priorEstimate = estimate;
  float priorError = estimateError + 0.15;

  kalmanGain = priorError / (priorError + measurementError);
  estimate = priorEstimate + kalmanGain * (measurement - priorEstimate);
  estimateError = (1 - kalmanGain) * priorError;

  return estimate;
}

// ==========================================
// EXPONENTIAL SMOOTHING FILTER
// ==========================================
float exponentialSmoothing(float measurement) {
  smoothedRSSI = smoothAlpha * measurement + (1 - smoothAlpha) * smoothedRSSI;
  return smoothedRSSI;
}

// ==========================================
// EXTENDED SLIDING WINDOW VARIANCE
// ==========================================
float analyzeWindowVariance() {
  float mean = 0;
  for(int i = 0; i < WINDOW_SIZE; i++) {
    mean += rssiWindow[i];
  }
  mean /= WINDOW_SIZE;

  float variance = 0;
  for(int i = 0; i < WINDOW_SIZE; i++) {
    variance += pow(rssiWindow[i] - mean, 2);
  }
  variance /= WINDOW_SIZE;

  return sqrt(variance);
}

// ==========================================
// LONG-TERM STABILITY DETECTOR
// ==========================================
float analyzeLongTermVariance() {
  float mean = 0;
  for(int i = 0; i < LONG_WINDOW; i++) {
    mean += rssiLongWindow[i];
  }
  mean /= LONG_WINDOW;

  float variance = 0;
  for(int i = 0; i < LONG_WINDOW; i++) {
    variance += pow(rssiLongWindow[i] - mean, 2);
  }
  variance /= LONG_WINDOW;

  return sqrt(variance);
}

// ==========================================
// RATE OF CHANGE DETECTION
// ==========================================
float detectRateOfChange() {
  if(windowIndex < 5) return 0;

  float recentMean = 0;
  for(int i = 0; i < 5; i++) {
    recentMean += rssiWindow[(windowIndex - i + WINDOW_SIZE) % WINDOW_SIZE];
  }
  recentMean /= 5;

  float oldMean = 0;
  for(int i = 5; i < 10; i++) {
    oldMean += rssiWindow[(windowIndex - i + WINDOW_SIZE) % WINDOW_SIZE];
  }
  oldMean /= 5;

  return abs(recentMean - oldMean);
}

// ==========================================
// PEAK DETECTION (SUDDEN CHANGES)
// ==========================================
float detectPeak() {
  if(windowIndex < 2) return 0;

  float current = rssiWindow[windowIndex - 1];
  float previous = rssiWindow[(windowIndex - 2 + WINDOW_SIZE) % WINDOW_SIZE];
  float older = rssiWindow[(windowIndex - 3 + WINDOW_SIZE) % WINDOW_SIZE];

  float delta1 = abs(current - previous);
  float delta2 = abs(previous - older);

  if(delta1 > (delta2 + 1)) {
    return delta1;
  }
  return 0;
}

// ==========================================
// Z-SCORE ANOMALY DETECTION
// ==========================================
float calculateZScore() {
  float mean = 0;
  for(int i = 0; i < WINDOW_SIZE; i++) {
    mean += rssiWindow[i];
  }
  mean /= WINDOW_SIZE;

  float variance = 0;
  for(int i = 0; i < WINDOW_SIZE; i++) {
    variance += pow(rssiWindow[i] - mean, 2);
  }
  variance /= WINDOW_SIZE;
  float stdDev = sqrt(variance);

  if(stdDev < 0.1) stdDev = 0.1;

  float current = rssiWindow[windowIndex - 1];
  return abs((current - mean) / stdDev);
}

// ==========================================
// SIGNAL QUALITY SCORER
// ==========================================
void updateSignalQuality() {
  float variance = analyzeWindowVariance();
  float longVariance = analyzeLongTermVariance();

  // Quality is inversely related to long-term stability
  signalQuality = max(0.0f, 100.0f - (longVariance * 20.0f));
  signalQuality = min(100.0f, signalQuality);

  // Signal is stable if long-term variance is low
  signalStable = (longVariance < 2.5);
}

// ==========================================
// ADVANCED CONFIDENCE CALCULATION
// ==========================================
int calculateAdvancedConfidence(float variance, float rateOfChange, float peak) {
  float conf = 0;

  // Variance-based confidence
  if(variance > fastMovementThreshold) {
    conf = 75;
  } else if(variance > slowMovementThreshold) {
    conf = 50;
  } else {
    conf = 15;
  }

  // Rate of change bonus
  if(rateOfChange > 2) {
    conf += 15;
  }

  // Peak detection bonus
  if(peak > 2) {
    conf += 10;
  }

  // Z-score confirmation
  float zScore = calculateZScore();
  if(zScore > zScoreThreshold) {
    conf += 10;
  }

  return min((int)conf, 100);
}

// ==========================================
// MOTION INTENSITY (IMPROVED)
// ==========================================
String getMotionIntensity(float variance, float rateOfChange) {
  if(variance > fastMovementThreshold && rateOfChange > 2.5) {
    return "SPRINT";
  } else if(variance > fastMovementThreshold) {
    return "FAST";
  } else if(variance > slowMovementThreshold && rateOfChange > 1) {
    return "WALKING";
  } else if(variance > slowMovementThreshold) {
    return "SLOW";
  } else {
    return "CALM";
  }
}

// ==========================================
// SETUP
// ==========================================
void setup() {
  Serial.begin(115200);
  pinMode(LED_PIN, OUTPUT);

  WiFi.begin(ssid, password);

  Serial.println("\n\n========== WiFi Presence Detector ==========");
  Serial.println("Connecting to WiFi...");

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("\nWiFi Connected!");
  Serial.println("Starting calibration...\n");

  // Extended calibration for better accuracy
  for(int i = 0; i < 200; i++) {
    float rssi = WiFi.RSSI();
    baseline = baseline * 0.95 + rssi * 0.05;
    smoothedRSSI = exponentialSmoothing(rssi);
    delay(30);
  }

  Serial.println("Calibration complete!");
  Serial.println("Baseline: " + String(baseline));
  Serial.println("\nOpening Tools > Serial Plotter...");
  Serial.println("==========================================\n");

  sessionStartTime = millis();
}

// ==========================================
// MAIN LOOP
// ==========================================
void loop() {
  int rawRSSI = WiFi.RSSI();

  // Apply dual filtering
  float kalmanFiltered = kalmanFilter(rawRSSI);
  float smoothFiltered = exponentialSmoothing(kalmanFiltered);

  // Store in windows
  rssiWindow[windowIndex] = smoothFiltered;
  rssiLongWindow[longWindowIndex] = smoothFiltered;

  windowIndex = (windowIndex + 1) % WINDOW_SIZE;
  longWindowIndex = (longWindowIndex + 1) % LONG_WINDOW;

  // Calculate metrics
  float variance = analyzeWindowVariance();
  rateOfChange = detectRateOfChange();
  float peak = detectPeak();

  // Update signal quality
  updateSignalQuality();

  // Adaptive baseline learning
  baseline = baseline * (1 - adaptiveAlpha) + smoothFiltered * adaptiveAlpha;
  baselineVariance = baselineVariance * (1 - adaptiveBeta) + variance * adaptiveBeta;

  // Get detection values
  float zScore = calculateZScore();
  confidenceScore = calculateAdvancedConfidence(variance, rateOfChange, peak);
  currentMotionIntensity = getMotionIntensity(variance, rateOfChange);

  // Primary detection: variance-based (reliable)
  bool varianceDetection = (variance > slowMovementThreshold);

  // Advanced metrics for confidence
  bool zScoreDetection = (zScore > zScoreThreshold);
  bool peakDetection = (peak > 2.0);
  bool rateDetection = (rateOfChange > 1.5);

  // Trigger on variance OR (strong multi-criteria confirmation)
  bool motion = varianceDetection || (zScoreDetection && peakDetection);

  if(motion) {
    disturbanceCounter++;
  } else {
    disturbanceCounter = 0;
  }

  bool detected = (disturbanceCounter >= persistenceRequired);

  if(detected) {
    digitalWrite(LED_PIN, LOW);
    if(disturbanceCounter == persistenceRequired) {
      totalDetections++;
      lastDetectionTime = millis();
    }
  } else {
    digitalWrite(LED_PIN, HIGH);
  }

  // ========== SERIAL PLOTTER OUTPUT ==========
  Serial.print("Raw:");
  Serial.print(rawRSSI);
  Serial.print(",");

  Serial.print("Kalman:");
  Serial.print(kalmanFiltered);
  Serial.print(",");

  Serial.print("Smooth:");
  Serial.print(smoothFiltered);
  Serial.print(",");

  Serial.print("Baseline:");
  Serial.print(baseline);
  Serial.print(",");

  Serial.print("Variance:");
  Serial.print(variance);
  Serial.print(",");

  Serial.print("ZScore:");
  Serial.print(zScore);
  Serial.print(",");

  Serial.print("Confidence:");
  Serial.println(confidenceScore);

  // ========== SERIAL MONITOR OUTPUT ==========
  Serial.print("[");
  Serial.print(currentMotionIntensity);
  Serial.print("] Conf:");
  Serial.print(confidenceScore);
  Serial.print("% | Quality:");
  Serial.print((int)signalQuality);
  Serial.print("% | Rate:");
  Serial.print(rateOfChange, 1);
  Serial.print(" | Total:");
  Serial.println(totalDetections);

  delay(35);
}
