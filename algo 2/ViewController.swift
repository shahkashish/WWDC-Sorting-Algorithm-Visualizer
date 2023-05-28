
    import UIKit
    import Charts
    import AVKit
    




    class SoundManager {
        static let instance = SoundManager()
        var player: AVAudioPlayer?
        func playSound() {
            guard let url = Bundle.main.url(forResource: "laser1", withExtension: ".mp3") else { return }
            do {
                player=try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch let error {
                print("Error playing sound. \(error.localizedDescription)")
            }
        }
        func playSound1() {
            guard let url = Bundle.main.url(forResource: "laser2", withExtension: ".mp3") else { return }
            do {
                player=try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch let error {
                print("Error playing sound. \(error.localizedDescription)")
            }
        }
        
    }



    class ViewController: UIViewController {
        
        @IBOutlet weak var speedLabel: UILabel!
        @IBOutlet weak var l4: UILabel!
        @IBOutlet weak var l3: UILabel!
        @IBOutlet weak var l2: UILabel!
        @IBOutlet weak var l1: UILabel!
        @IBOutlet weak var blue: UILabel!
        @IBOutlet weak var yellow: UILabel!
        @IBOutlet weak var green: UILabel!
        @IBOutlet weak var red: UILabel!
        @IBOutlet weak var colonLabel: UILabel!
        @IBOutlet weak var iterationsLabel: UILabel!
        @IBOutlet weak var ofLabel: UILabel!
        @IBOutlet weak var numberLabel: UILabel!
        @IBOutlet weak var heading2: UILabel!
        @IBOutlet weak var heading1: UILabel!
        @IBOutlet weak var label: UILabel!
        @IBOutlet weak var sliderVal: UISlider!
        @IBOutlet weak var speedSlider: UISlider!
        @IBOutlet weak var bubbleSortButton: UIButton!
        @IBOutlet weak var quickSortButton: UIButton!
        @IBOutlet weak var iterations: UILabel!
        override func viewDidLoad() {
            colonLabel.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            super.viewDidLoad()
            sliderVal.value = 10
            speedSlider.value = 0.2
            speedLabel.text = String(format: "%.1f sec", speedSlider.value)
            red.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            yellow.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            green.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            blue.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            l1.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            l2.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            l3.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            l4.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            heading2.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            colonLabel.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            iterations.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            iterationsLabel.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            ofLabel.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            numberLabel.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            label.text = String(Int(sliderVal.value))
            createChart(flag: 0, sliderData: 10)
            // Do any additional setup after loading the view.
            
        }
        
        var timerFlag = 0
        private var colors = [UIColor]()
        var entries = [BarChartDataEntry]()
        var entriesCopy = [BarChartDataEntry]()
        var barChart = BarChartView()
        var set: BarChartDataSet!
        var shouldStop = false
        
        private func changeColor(index: Int, newColor: UIColor){
            colors[index] = newColor
        }
        
        func createChart(flag:Int, sliderData:Int) {
            
            
            
            // Create bar chart
            removeChart()
            let barChart = BarChartView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
            // Configure the axis
            let xAxis = barChart.xAxis
//            let yAxis = barChart.rightAxis
            // Configure legend
            // Supply data
            if flag == 0 {
                entries.removeAll()
                for x in 0..<sliderData {
                    entries.append(
                        BarChartDataEntry(
                            x: Double(x),
                            y: Double.random(in: 0...30)
                        )
                    )
                }
                entriesCopy = entries
                colors = Array(repeating: UIColor.red, count: entries.count)
            }
            set = BarChartDataSet(entries: entries, label: "Cost")
            set.colors = colors
            set.drawValuesEnabled = false
            let data = BarChartData(dataSet: set)
            barChart.data = data
            barChart.xAxis.drawGridLinesEnabled = false
            barChart.leftAxis.drawGridLinesEnabled = false
            barChart.rightAxis.drawGridLinesEnabled = false
            barChart.drawBordersEnabled = false
            barChart.legend.enabled = false
            xAxis.enabled = false
            xAxis.labelPosition = .bottom
            barChart.leftAxis.enabled = false
            barChart.rightAxis.enabled = false

            view.addSubview (barChart)
            barChart.center=view.center
        
        }
        
        private func updateColor(index1: Int, index2: Int){
            colors[index1] = NSUIColor(red: 35/255.0, green: 180/255.0, blue: 84/255.0, alpha: 1.0)
            colors[index2] = NSUIColor(red: 35/255.0, green: 180/255.0, blue: 84/255.0, alpha: 1.0)
        }
        var i = 0
        var j = 0
        var iter = 1
        var timer: Timer?
        func slowSort(flag: Int) {
            if flag == 0 {
                i = 0
                j = 0
                iter = 1
            }
            
            timer=Timer.scheduledTimer(withTimeInterval: TimeInterval(speedSlider.value), repeats: true) { [weak self] timer in
                guard let self = self else {
                    timer.invalidate()
                    return
                }
                
                self.iter+=1
                if self.i < self.entries.count {
                    
                    if self.j < self.entries.count {
                        for x in self.i..<self.entries.count {
                            self.changeColor(index: x, newColor: UIColor.red)
                        }
                        self.colors[self.i] = NSUIColor(red: 255/255.0, green: 201/255.0, blue: 18/255.0, alpha: 1.0)
                        self.iterations.text = String(self.iter)
                        self.colors[self.j] = NSUIColor(red: 255/255.0, green: 201/255.0, blue: 18/255.0, alpha: 1.0)
                        self.createChart(flag: 1, sliderData: Int(self.sliderVal.value))
                        if self.entries[self.j].y < self.entries[self.i].y {
                            // Swap elements
                            self.updateColor(index1: self.i, index2: self.j)
                            self.createChart(flag: 1, sliderData: Int(self.sliderVal.value))
                            let temp = self.entries[self.i].y
                            self.entries[self.i].y = self.entries[self.j].y
                            self.entries[self.j].y = temp
                            // Create bar chart
                            self.createChart(flag: 1, sliderData: Int(self.sliderVal.value))
                            SoundManager.instance.playSound()
                        }
                        self.j += 1
                        
                    } else {
                        self.colors[self.i] = UIColor.blue
                        self.i += 1
                        self.j = self.i + 1
                        
                    }
                    
                } else {
                    timer.invalidate()
                    
                    self.timerFlag=0
//                    self.colors = Array(repeating: UIColor.red, count: self.entries.count)
//                    self.createChart(flag: 1, sliderData: Int(self.sliderVal.value))
                    self.quickSortButton.isEnabled = true
                    self.sliderVal.isEnabled = true
                    self.bubbleSortButton.isEnabled = true
                    self.colorRun()
                }
            }
        }
        
        func quickSort(start: Int, end: Int) async {
            if start >= end || shouldStop{
                return
            }
            
            let index = await partition(start: start, end: end)
            createChart(flag: 1, sliderData: Int(self.sliderVal.value))
            await withTaskGroup(of: Void.self) { group in
               await group.addTask { [self] in
                    await self.quickSort(start: start, end: index - 1)
                    await self.createChart(flag: 1, sliderData: Int(self.sliderVal.value))
                   if await shouldStop {
                       await createChart(flag: 2, sliderData: Int(self.sliderVal.value))
                       return
                   }
                }
                await group.addTask {
                    await self.quickSort(start: index+1, end: end)
                    await self.createChart(flag: 1, sliderData: Int(self.sliderVal.value))
                    if await self.shouldStop {
                        await self.createChart(flag: 2, sliderData: Int(self.sliderVal.value))
                        return
                    }
                }
            }
            if start == 0 && end == entries.count - 1{
                if self.shouldStop {
                    entries = entriesCopy
                    createChart(flag: 1, sliderData: Int(self.sliderVal.value))
                    return
                }
                colorRun()
            }
            if self.shouldStop {
                entries = entriesCopy
                createChart(flag: 1, sliderData: Int(self.sliderVal.value))
                return
            }
            for i in start..<end+1 {
                changeColor(index: i, newColor: UIColor.blue)
            }
  //          createChart(flag: 1, sliderData: Int(self.sliderVal.value))
        }

        func colorRun() {
            
            var i = 0
            let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                
//                if self.shouldStop {
//                    timer.invalidate()
//                    return
//                }
                if i < self.entries.count - 2{
                    self.colors = Array(repeating: UIColor.blue, count: self.entries.count)
                    self.changeColor(index: i, newColor: UIColor.black)
                    self.changeColor(index: i+1, newColor: UIColor.black)
                    self.changeColor(index: i+2, newColor: UIColor.black)
                    self.createChart(flag: 1, sliderData: Int(self.sliderVal.value))
                    i += 1
                } else {
                    timer.invalidate()
                    self.colors = Array(repeating: UIColor.blue, count: self.entries.count)
                    self.createChart(flag: 1, sliderData: Int(self.sliderVal.value))
                    self.bubbleSortButton.isEnabled = true
                    self.sliderVal.isEnabled = true
                    self.quickSortButton.isEnabled = true
                    self.quickSortButton.backgroundColor = UIColor.white
                }
            }
            }
        private func partition(start : Int, end: Int) async -> Int  {
            let pivotValue = entries[end].y
            var pivotIndex = start
//            changeColor(index: pivotIndex, newColor: UIColor.brown)
//            createChart(flag: 1, sliderData: Int(self.sliderVal.value))
            try? await Task.sleep(nanoseconds: UInt64((self.speedSlider.value) * 300000000) )
            for i in start..<end {
                iter+=1
                iterations.text = String(iter)
                if(entries[i].y < pivotValue){
                    SoundManager.instance.playSound()
                    await swapIndex(a: i, b: pivotIndex)
                    pivotIndex+=1
                    if self.shouldStop {
                        entries = entriesCopy
                        createChart(flag: 1, sliderData: Int(self.sliderVal.value))
                        return 0
                    }
                    updateColor(index1: i, index2: pivotIndex)
                    createChart(flag: 1, sliderData: Int(self.sliderVal.value))
                    try? await Task.sleep(nanoseconds: UInt64((self.speedSlider.value) * 300000000) )
                    for i in start..<end+1 {
                        changeColor(index: i, newColor: UIColor.red)
                    }
                    if self.shouldStop {
                        entries = entriesCopy
                        createChart(flag: 1, sliderData: Int(self.sliderVal.value))
                        return 0
                    }
                    changeColor(index: pivotIndex, newColor: NSUIColor(red: 255/255.0, green: 201/255.0, blue: 18/255.0, alpha: 1.0))
                  //  try? await Task.sleep(nanoseconds: 500000000)
                    createChart(flag: 1, sliderData: Int(self.sliderVal.value))
                    try? await Task.sleep(nanoseconds: UInt64((self.speedSlider.value) * 300000000) )
                }
            }
            await swapIndex(a: end, b: pivotIndex)
          //  try? await Task.sleep(nanoseconds: 100000000)
            createChart(flag: 1, sliderData: Int(self.sliderVal.value))
            return pivotIndex
        }
        private func swapIndex(a: Int, b: Int) async {
            try? await Task.sleep(nanoseconds: UInt64((self.speedSlider.value) * 300000000) )
            let temp = entries[a].y
            entries[a].y = entries[b].y
            entries[b].y = temp
            
        }
        private func removeChart() {

            if let barChart = view.subviews.first(where: { $0 is BarChartView }) as? BarChartView {

                barChart.removeFromSuperview()

            }

        }
        @IBAction func slider(_ sender: Any) {
            label.text = String(Int(sliderVal.value))
            createChart(flag: 0, sliderData: Int(sliderVal.value))
            red.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            yellow.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            green.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            blue.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            l1.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            l2.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            l3.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            l4.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            heading1.text = "Sort Visualizer"
            heading2.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            colonLabel.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            colonLabel.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            iterations.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            iterationsLabel.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            ofLabel.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            numberLabel.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
        }
        @IBAction func sortButton(_ sender: Any) {
            timerFlag = 2
            heading1.text = "Bubble Sort"
            heading2.text = "Smallest Bubble Scheme"
            red.textColor = UIColor.red
            yellow.textColor = NSUIColor(red: 255/255.0, green: 201/255.0, blue: 18/255.0, alpha: 1.0)
            blue.textColor = UIColor.blue
            green.textColor = NSUIColor(red: 35/255.0, green: 180/255.0, blue: 84/255.0, alpha: 1.0)
            l1.textColor = UIColor.black
            l2.textColor = UIColor.black
            l2.text = "Current Pointer Element"
            l3.textColor = UIColor.black
            l4.textColor = UIColor.black
            bubbleSortButton.isEnabled = false
            bubbleSortButton.layer.cornerRadius = 10
            colonLabel.textColor = UIColor.black
              colonLabel.textColor = UIColor.black
              iterations.textColor = UIColor.black
              iterationsLabel.textColor = UIColor.black
              ofLabel.textColor = UIColor.black
              numberLabel.textColor = UIColor.black
            heading2.textColor = UIColor.darkGray
            quickSortButton.isEnabled = false
            sliderVal.isEnabled = false
            slowSort(flag: 0)
            
        }
        @IBAction func quickSort(_ sender: Any) {
            timerFlag = 1
            iter = 0
            red.textColor = UIColor.red
            yellow.textColor = NSUIColor(red: 255/255.0, green: 201/255.0, blue: 18/255.0, alpha: 1.0)
            blue.textColor = UIColor.blue
            green.textColor = NSUIColor(red: 35/255.0, green: 180/255.0, blue: 84/255.0, alpha: 1.0)
            l1.textColor = UIColor.black
            l2.textColor = UIColor.black
            l2.text = "Current Pivot Elements"
            l3.textColor = UIColor.black
            l4.textColor = UIColor.black
            colonLabel.textColor = UIColor.black
              colonLabel.textColor = UIColor.black
              iterations.textColor = UIColor.black
              iterationsLabel.textColor = UIColor.black
              ofLabel.textColor = UIColor.black
              numberLabel.textColor = UIColor.black
            heading2.textColor = UIColor.darkGray
            heading1.text = "Quick Sort"
            heading2.text = "Hoare Partition Scheme"
            shouldStop = false
            quickSortButton.layer.cornerRadius = 14
           // quickSortButton.backgroundColor = UIColor.systemBlue
            bubbleSortButton.isEnabled = false
            sliderVal.isEnabled = false
            quickSortButton.isEnabled = false
            Task { @MainActor in
                await quickSort(start: 0, end: entries.count - 1)
                if shouldStop {
                    return
                }
                createChart(flag: 1, sliderData: Int(self.sliderVal.value))
                
            }
            

        }
        @IBAction func stopButton(_ sender: Any) {
            timer?.invalidate()
            shouldStop = true
            red.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            yellow.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            green.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            blue.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            l1.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            l2.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            l3.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            l4.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            heading1.text = "Sort Visualizer"
            heading2.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
            self.bubbleSortButton.isEnabled = true
            self.sliderVal.isEnabled = true
            self.quickSortButton.isEnabled = true
            colors = Array(repeating: UIColor.red, count: entries.count)
            entries = entriesCopy
            createChart(flag: 2, sliderData: Int(self.sliderVal.value))
              colonLabel.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
              colonLabel.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
              iterations.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
              iterationsLabel.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
              ofLabel.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
              numberLabel.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
     //       heading1.textColor = NSUIColor(red: 244, green: 244, blue: 250, alpha: 0)
        }
        @IBAction func slidervaluechanged(_ sender: Any) {
            speedLabel.text = String(format: "%.1f sec", speedSlider.value)
            if timerFlag == 2 {
                timer?.invalidate()
                slowSort(flag: 1)
            }
            
        }
    }
