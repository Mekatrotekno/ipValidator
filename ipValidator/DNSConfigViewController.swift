//
//  DNSConfigViewController.swift
//  ipValidator
//
//  Created by Mehmet emin Kartal on 9/18/16.
//  Copyright © 2016 Mehmet Emin KARTAL
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.


import UIKit

class DNSConfigViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource{
	
	@IBOutlet weak var GWPicker: UIPickerView!
	@IBOutlet weak var DNSPicker: UIPickerView!
	
	
	
	var Subnet: [Int] = [0,0,0,0];
	var IPaddr: [Int] = [0,0,0,0];
	var BroadcastIP: [Int] = [0,0,0,0]
	var networkSize = 0;
	var space: [Int] = [0,0,0,0]
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
//		
		GWPicker.selectRow(0, inComponent: 0, animated: false);
		GWPicker.selectRow(0, inComponent: 1, animated: false);
		GWPicker.selectRow(0, inComponent: 2, animated: false);
		GWPicker.selectRow(1, inComponent: 3, animated: false);
//		
		
		DNSPicker.selectRow(8, inComponent: 0, animated: false);
		DNSPicker.selectRow(8, inComponent: 1, animated: false);
		DNSPicker.selectRow(8, inComponent: 2, animated: false);
		DNSPicker.selectRow(8, inComponent: 3, animated: false);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 4
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		if pickerView == GWPicker {
			return space[component] + (component != 3 ? 1 : 0);
		}
		return 255
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		if pickerView == GWPicker {
			let s = IPaddr[component] & Subnet[component];
			return "\(s + row)"
		}
		return "\(row)"
	}
	
	
	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? ExportViewController {
			dest.BroadcastIP = self.BroadcastIP
			
			dest.networkSize = self.networkSize;
			dest.IPaddr = self.IPaddr
			dest.Subnet = self.Subnet
			dest.space = space;
			var GWIP = [0,0,0,0];
			var DNSIP = [0,0,0,0];
			for i in 0...3 {
				
				GWIP[i] = (IPaddr[i] & Subnet[i]) + GWPicker.selectedRow(inComponent: i)
				DNSIP[i] = DNSPicker.selectedRow(inComponent: i)
			}
			dest.GWaddr = GWIP
			dest.DNSaddr = DNSIP
		}
    }
}
