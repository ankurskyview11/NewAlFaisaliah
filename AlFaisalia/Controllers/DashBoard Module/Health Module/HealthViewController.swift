//
//  HealthViewController.swift
//  NupcoEmployeeApp
//
//  Created by Ankur Verma on 12/08/21.
//

import UIKit
import AVFoundation
import CoreMotion
import Dispatch

class HealthViewController: UIViewController {

    @IBOutlet weak var tapViewHeartRate: UIView!
    @IBOutlet weak var heartRateView: UIView!
    @IBOutlet weak var stepCountView: UIView!
    
    @IBOutlet weak var btnHeartRate: UIButton!
    @IBOutlet weak var btnStepCount: UIButton!
    
    @IBOutlet weak var stepImageView: UIImageView!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var previewImageView: UIImageView!
    
    @IBOutlet weak var previewStepImageView: UIImageView!
    
    @IBOutlet weak var previewStepView: UIView!
    
    //Heart Rate Module
      @IBOutlet weak var previewLayerShadowView: UIView!
      @IBOutlet weak var previewLayer: UIView!
      @IBOutlet weak var pulseLabel: UILabel!
      @IBOutlet weak var thresholdLabel: UILabel!
      
      private var validFrameCounter = 0
      private var heartRateManager: HeartRateManager!
      private var hueFilter = Filter()
      private var pulseDetector = PulseDetector()
      private var inputs: [CGFloat] = []
      private var measurementStartedFlag = false
      private var timer = Timer()
    //
    
    // Step Count Module
     private let activityManager = CMMotionActivityManager()
     private let pedometer = CMPedometer()
     private var shouldStartUpdating: Bool = false
     private var startDate: Date? = nil
     
     @IBOutlet weak var startButton: UIButton!
     @IBOutlet weak var stepsCountLabel: UILabel!
    @IBOutlet weak var stepUpdateLabel: UILabel!
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        segmentView.layer.borderWidth = 1
        segmentView.layer.borderColor = UIColor.lightGray.cgColor
        
        //btnHeartRate.clipsToBounds = true
        btnHeartRate.layer.cornerRadius = 6
        btnHeartRate.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        btnStepCount.layer.cornerRadius = 6
        btnStepCount.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
        heartRateView.isHidden = false
        btnHeartRate.backgroundColor = UIColor(named: ACCENT_COLOR)
        heartImageView.image = UIImage(named: "whiteHeartRate")
        btnHeartRate.titleLabel?.textColor = UIColor.white
        
        stepCountView.isHidden = true
        btnStepCount.backgroundColor = supportingfuction.colorWithHexString("#F3F3F3")
        stepImageView.image = UIImage(named: "grayStepCount")
        btnStepCount.titleLabel?.textColor = UIColor.lightGray
        
        tapViewHeartRate.isHidden = false
        previewLayerShadowView.isHidden = true
        
            initVideoCapture()
            
          // thresholdLabel.text = "Cover the back camera until the image turns red 🟥"
        thresholdLabel.text = "TAP HERE TO START"
        thresholdLabel.adjustsFontSizeToFitWidth = true
        let imageName = UIImage.gifImageWithName("heartRateGifPro")
        previewImageView.image = imageName
        previewImageView.layer.cornerRadius = 40
        previewImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        previewImageView.isHidden = true
        previewImageView.backgroundColor = UIColor(named: ACCENT_COLOR)
        
        
        let stepsImageName = UIImage.gifImageWithName("circlePulse")
        previewStepImageView.image = stepsImageName
        //previewImageView.layer.cornerRadius = 40
        //previewImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        previewStepImageView.isHidden = true
        previewStepView.isHidden = true
        previewStepImageView.backgroundColor = UIColor(named: ACCENT_COLOR)
        previewStepView.layer.cornerRadius = 40
        previewStepView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        stepUpdateLabel.text = "TAP HERE TO START"
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupPreviewView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        guard let startDate = startDate else { return }
        updateStepsCountLabelUsing(startDate: startDate)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        deinitCaptureSession()
    }
    @IBAction func btnAction_Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func btnAction_HeartRate(_ sender: Any) {
        heartRateView.isHidden = false
        btnHeartRate.backgroundColor = UIColor(named: ACCENT_COLOR)
        btnHeartRate.titleLabel?.textColor = UIColor.white
        heartImageView.image = UIImage(named: "whiteHeartRate")
        
        stepCountView.isHidden = true
        btnStepCount.backgroundColor = supportingfuction.colorWithHexString("#F3F3F3")
        stepImageView.image = UIImage(named: "grayStepCount")
        btnStepCount.titleLabel?.textColor = UIColor.lightGray
        
        tapViewHeartRate.isHidden = false
        previewLayerShadowView.isHidden = true
        previewImageView.isHidden = true
        deinitCaptureSession()
        previewStepImageView.isHidden = true
        previewStepView.isHidden = true
        
    }
    
    @IBAction func btnAction_StepCount(_ sender: Any) {
        heartRateView.isHidden = true
        btnHeartRate.backgroundColor = supportingfuction.colorWithHexString("#F3F3F3")
        btnHeartRate.titleLabel?.textColor = UIColor.lightGray
        heartImageView.image = UIImage(named: "grayHeartRate")
        
        stepCountView.isHidden = false
        btnStepCount.backgroundColor = UIColor(named: ACCENT_COLOR)
        stepImageView.image = UIImage(named: "whiteStepCount")
        btnStepCount.titleLabel?.textColor = UIColor.white
        
        previewLayerShadowView.isHidden = true
        previewImageView.isHidden = true
        deinitCaptureSession()
        thresholdLabel.text = "TAP HERE TO START"
        
        previewStepImageView.isHidden = true
        previewStepView.isHidden = true
    }
    
    @IBAction func btnAction_TapToGetHeartRate(_ sender: Any) {
        print("GET HEART RATE")
        tapViewHeartRate.isHidden = true
        previewLayerShadowView.isHidden = false
        initCaptureSession()
         
       
         
    }
    
    
    @IBAction func btnAction_TapToStartCountSteps(_ sender: Any) {
        print("START STEP COUNT")
        previewStepImageView.isHidden = false
        previewStepView.isHidden = false
        
        shouldStartUpdating = !shouldStartUpdating
        shouldStartUpdating ? (onStart()) : (onStop())
        
        
    }
    
    // MARK: - Setup Views
    private func setupPreviewView() {
        previewLayer.layer.cornerRadius = 45.0
        previewLayer.layer.masksToBounds = true
        
        previewLayerShadowView.backgroundColor = .clear
        previewLayerShadowView.layer.shadowColor = UIColor.black.cgColor
        previewLayerShadowView.layer.shadowOpacity = 0.25
        previewLayerShadowView.layer.shadowOffset = CGSize(width: 0, height: 3)
        previewLayerShadowView.layer.shadowRadius = 3
        previewLayerShadowView.clipsToBounds = false
    }
    
    // MARK: - Frames Capture Methods
    private func initVideoCapture() {
        let specs = VideoSpec(fps: 30, size: CGSize(width: 300, height: 300))
        heartRateManager = HeartRateManager(cameraType: .back, preferredSpec: specs, previewContainer: previewLayer.layer)
        heartRateManager.imageBufferHandler = { [unowned self] (imageBuffer) in
            self.handle(buffer: imageBuffer)
        }
    }
    
    // MARK: - AVCaptureSession Helpers
    private func initCaptureSession() {
        heartRateManager.startCapture()
    }
    
    private func deinitCaptureSession() {
        heartRateManager.stopCapture()
        toggleTorch(status: false)
    }
    
    private func toggleTorch(status: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        device.toggleTorch(on: status)
    }
    
    // MARK: - Measurement
    private func startMeasurement() {
        DispatchQueue.main.async {
            self.toggleTorch(status: true)
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] (timer) in
                guard let self = self else { return }
                let average = self.pulseDetector.getAverage()
                let pulse = 60.0/average
                if pulse == -60 {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.pulseLabel.alpha = 0
                    }) { (finished) in
                        self.pulseLabel.isHidden = finished
                    }
                } else {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.pulseLabel.alpha = 1.0
                    }) { (_) in
                        self.pulseLabel.isHidden = false
                        self.pulseLabel.text = "\(lroundf(pulse)) Bpm"
                    }
                }
            })
        }
    }


    
}
//MARK: - Handle Image Buffer
extension HealthViewController {
    fileprivate func handle(buffer: CMSampleBuffer) {
        var redmean:CGFloat = 0.0;
        var greenmean:CGFloat = 0.0;
        var bluemean:CGFloat = 0.0;
        
        let pixelBuffer = CMSampleBufferGetImageBuffer(buffer)
        let cameraImage = CIImage(cvPixelBuffer: pixelBuffer!)

        let extent = cameraImage.extent
        let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
        let averageFilter = CIFilter(name: "CIAreaAverage",
                              parameters: [kCIInputImageKey: cameraImage, kCIInputExtentKey: inputExtent])!
        let outputImage = averageFilter.outputImage!

        let ctx = CIContext(options:nil)
        let cgImage = ctx.createCGImage(outputImage, from:outputImage.extent)!
        
        let rawData:NSData = cgImage.dataProvider!.data!
        let pixels = rawData.bytes.assumingMemoryBound(to: UInt8.self)
        let bytes = UnsafeBufferPointer<UInt8>(start:pixels, count:rawData.length)
        var BGRA_index = 0
        for pixel in UnsafeBufferPointer(start: bytes.baseAddress, count: bytes.count) {
            switch BGRA_index {
            case 0:
                bluemean = CGFloat (pixel)
            case 1:
                greenmean = CGFloat (pixel)
            case 2:
                redmean = CGFloat (pixel)
            case 3:
                break
            default:
                break
            }
            BGRA_index += 1
        }
        
        let hsv = rgb2hsv((red: redmean, green: greenmean, blue: bluemean, alpha: 1.0))
        // Do a sanity check to see if a finger is placed over the camera
        if (hsv.1 > 0.5 && hsv.2 > 0.5) {
            DispatchQueue.main.async {
                self.thresholdLabel.text = "PLACE YOUR FINGER ON FLASHLIGHT"
                self.toggleTorch(status: true)
                if !self.measurementStartedFlag {
                    self.startMeasurement()
                    self.measurementStartedFlag = true
                    self.previewImageView.isHidden = false//
                }
            }
            validFrameCounter += 1
            inputs.append(hsv.0)
            // Filter the hue value - the filter is a simple BAND PASS FILTER that removes any DC component and any high frequency noise
            let filtered = hueFilter.processValue(value: Double(hsv.0))
            if validFrameCounter > 60 {
              let val =   self.pulseDetector.addNewValue(newVal: filtered, atTime: CACurrentMediaTime())
                print("HR ==> \(val)")
            }
        } else {
            validFrameCounter = 0
            measurementStartedFlag = false
            pulseDetector.reset()
            DispatchQueue.main.async {
                self.thresholdLabel.text = "Cover the back camera until the image turns red."
                self.previewImageView.isHidden = true//
            }
        }
    }
}
extension HealthViewController {
   private func onStart() {
       // startButton.setTitle("Stop", for: .normal)
    stepUpdateLabel.text = "TAP HERE TO STOP"
    stepsCountLabel.text = "0 Steps"
        startDate = Date()
        checkAuthorizationStatus()
        startUpdating()
    }

    private func onStop() {
       // startButton.setTitle("Start", for: .normal)
        stepUpdateLabel.text = "TAP HERE TO START"
        startDate = nil
        stopUpdating()
    }

    private func startUpdating() {
        if CMMotionActivityManager.isActivityAvailable() {
            startTrackingActivityType()
        } else {
           // activityTypeLabel.text = "Not available"
        }

        if CMPedometer.isStepCountingAvailable() {
            startCountingSteps()
        } else {
            stepsCountLabel.text = "Not available"
        }
    }

    private func checkAuthorizationStatus() {
        switch CMMotionActivityManager.authorizationStatus() {
        case CMAuthorizationStatus.denied:
            onStop()
           // activityTypeLabel.text = "Not available"
            stepsCountLabel.text = "Not available"
        default:break
        }
    }

    private func stopUpdating() {
        activityManager.stopActivityUpdates()
        pedometer.stopUpdates()
        pedometer.stopEventUpdates()
    }

    private func on(error: Error) {
        //handle error
    }

    private func updateStepsCountLabelUsing(startDate: Date) {
        pedometer.queryPedometerData(from: startDate, to: Date()) {
            [weak self] pedometerData, error in
            if let error = error {
                self?.on(error: error)
            } else if let pedometerData = pedometerData {
                DispatchQueue.main.async {
                    self?.stepsCountLabel.text = "\(String(describing: pedometerData.numberOfSteps)) Steps"
                }
            }
        }
    }

    private func startTrackingActivityType() {
        activityManager.startActivityUpdates(to: OperationQueue.main) {
            [weak self] (activity: CMMotionActivity?) in
            guard let activity = activity else { return }
            DispatchQueue.main.async {
                if activity.walking {
                   // self?.activityTypeLabel.text = "Walking"
                } else if activity.stationary {
                   // self?.activityTypeLabel.text = "Stationary"
                } else if activity.running {
                   // self?.activityTypeLabel.text = "Running"
                } else if activity.automotive {
                   // self?.activityTypeLabel.text = "Automotive"
                }
            }
        }
    }

    private func startCountingSteps() {
        pedometer.startUpdates(from: Date()) {
            [weak self] pedometerData, error in
            guard let pedometerData = pedometerData, error == nil else { return }

            DispatchQueue.main.async {
                self?.stepsCountLabel.text = "\(pedometerData.numberOfSteps.stringValue) Steps"
            }
        }
    }
//     @objc private func didTapStartButton() {
//         shouldStartUpdating = !shouldStartUpdating
//         shouldStartUpdating ? (onStart()) : (onStop())
//     }
}
