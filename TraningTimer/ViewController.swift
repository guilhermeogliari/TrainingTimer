//
//  ViewController.swift
//  TraningTimer
//
//  Created by Guilherme Ogliari on 25/05/17.
//  Copyright © 2017 Guilherme Ogliari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lblRepeticoes: UILabel!
    @IBOutlet weak var lblDescanso: UILabel!
    @IBOutlet weak var lblContTempo: UILabel!
    @IBOutlet weak var lblContRepeticoes: UILabel!
    @IBOutlet weak var sldRepeticoes: UISlider!
    @IBOutlet weak var sldTempo: UISlider!
    @IBOutlet weak var btnStart: UIButton!
    
    var repeticoes: Int = 1
    var tempo: Int = 10
    var hora: Int = 0
    var minuto: Int = 0
    var segundos: Int = 0
    var tempoDec: Int = 0
    var timer = Timer()
    let generator = UIImpactFeedbackGenerator(style: .heavy)

    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func sldChangeRepeat(_ sender: UISlider) {
        if(Int(sender.value) != 1){
            lblRepeticoes.text = String(Int(sender.value))+" Séries"
        }else{
            lblRepeticoes.text = String(Int(sender.value))+" Série"
        }
        lblContRepeticoes.text = String(Int(sender.value))
        repeticoes = Int(sender.value)
    }
    
    @IBAction func sldChangeTime(_ sender: UISlider) {
        if(Int(sender.value) < 60){
            lblDescanso.text = String(Int(sender.value))+" Segundos de descanso"
        }else if(Int(sender.value) >= 60 && Int(sender.value) < 120 ){
            if(((Int(sender.value) % 3600) % 60) != 0){
                lblDescanso.text = String(Int(sender.value)/60)+" Minuto e "+String((Int(sender.value) % 3600) % 60)+" segundos de descanso"
            }else{
                lblDescanso.text = String(Int(sender.value)/60)+" Minuto de descanso"
            }
        }else{
            if(((Int(sender.value) % 3600) % 60) != 0){
                lblDescanso.text = String(Int(sender.value)/60)+" Minutos e "+String((Int(sender.value) % 3600) % 60)+" segundos de descanso"
            }else{
                lblDescanso.text = String(Int(sender.value)/60)+" Minutos de descanso"
            }
        }
        lblContTempo.text = String(describing: secondsToHoursMinutesSeconds(seconds: Int(sender.value)))
        tempo = Int(sender.value)
    }
    
    @IBAction func btnClickStart(_ sender: UIButton) {
        timer.invalidate()
        generator.impactOccurred()
        tempoDec = tempo
        if(repeticoes>0){
            repeticoes -= 1
        }
        lblContRepeticoes.text = String(repeticoes)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        sldTempo.isEnabled = false
        sldRepeticoes.isEnabled = false
        btnStart.isEnabled = false
        btnStart.alpha = 0.1
    }
    
    func timerAction() {
        tempoDec -= 1
        lblContTempo.text = String(describing: secondsToHoursMinutesSeconds(seconds: Int(tempoDec)))
        if(tempoDec==0){
            timer.invalidate()
            lblContTempo.text = String(describing: secondsToHoursMinutesSeconds(seconds: Int(tempo)))
            sldTempo.isEnabled = true
            sldRepeticoes.isEnabled = true
            btnStart.isEnabled = true
            btnStart.alpha = 1.0
            generator.impactOccurred()
        }
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (String) {
        hora = (seconds / 3600)
        minuto = ((seconds % 3600) / 60)
        segundos = ((seconds % 3600) % 60)
        return String(format:"%02d:%02d", minuto, segundos)
    }
    
}

