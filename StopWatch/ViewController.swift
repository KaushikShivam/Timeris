//
//  ViewController.swift
//  StopWatch
//
//  Created by shivam kaushik on 17/05/15.
//  Copyright (c) 2015 shivam kaushik. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var stopwatchLabel: UILabel!
  @IBOutlet weak var lapsTableView: UITableView!
  @IBOutlet weak var startStopButton: UIButton!
  @IBOutlet weak var lapResetButton: UIButton!
  
  
  var timer = NSTimer()
  var minutes = 0
  var seconds = 0
  var fractions = 0
  
  var startStopWatch = true
  var addLap = false
  
  var stopwatchString = ""
  
  var laps: [String] = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    stopwatchLabel.text = "00:00.00"
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //Tableview data source
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return laps.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//    let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
//    cell.backgroundColor = self.view.backgroundColor
//    cell.textLabel?.text = "Lap \(laps.count - indexPath.row)"
//    cell.detailTextLabel?.text = laps[indexPath.row]
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell
    let lapCount = cell.viewWithTag(1001) as! UILabel
    let lapDetails = cell.viewWithTag(1002) as! UILabel
    
    lapCount.text = "\(laps.count - indexPath.row)"
    lapDetails.text = laps[indexPath.row]
    
    return cell
  }

  @IBAction func startStopButtonPressed(sender: UIButton) {
    if startStopWatch == true {
      timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateStopwatch"), userInfo: nil, repeats: true)
      startStopWatch = false
      
      startStopButton.setImage(UIImage(named: "Stop.png"), forState: UIControlState.Normal)
      lapResetButton.setImage(UIImage(named: "Lap.png"), forState: UIControlState.Normal)
      addLap = true
    } else {
      timer.invalidate()
      startStopWatch = true
      startStopButton.setImage(UIImage(named: "Start.png"), forState: UIControlState.Normal)
      lapResetButton.setImage(UIImage(named: "Reset.png"), forState: UIControlState.Normal)
      addLap = false
    }
  }

  @IBAction func lapResetButtonPressed(sender: UIButton) {
    if addLap == true {
      laps.insert(stopwatchString, atIndex: 0)
      lapsTableView.reloadData()
    } else {
      addLap = false
      lapResetButton.setImage(UIImage(named: "Lap.png"), forState: UIControlState.Normal)
      laps.removeAll(keepCapacity: false)
      lapsTableView.reloadData()
      fractions = 0
      seconds = 0
      minutes = 0
      stopwatchString = "00:00.00"
      stopwatchLabel.text = stopwatchString
    }
  }
  
  
  func updateStopwatch() {
    fractions += 1
    if fractions == 100 {
      seconds += 1
      fractions = 0
    }
    
    if seconds == 60 {
      minutes += 1
      seconds = 0
    }
    
    let fractionString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
    let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
    let minuteString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
    
    stopwatchString = "\(minuteString):\(secondsString).\(fractionString)"
    stopwatchLabel.text = stopwatchString
  }
  
  
  
}

