//
//  ViewController.swift
//  TapForFun
//
//  Created by Alexandra Beznosova on 06/07/2019.
//  Copyright © 2019 Divine App. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var advice: UIImageView!
	
	@IBOutlet weak var shareButton: UIButton!
	var adviceText: Advice?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Additional setup after loading the view.
		shareButton.layer.borderColor = UIColor.white.cgColor
		shareButton.layer.borderWidth = 2.0
		getAdvice()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		getAdvice()
	}
	
	@IBAction func onSharePressed(_ sender: UIButton) {
		
		guard let advice = adviceText else {
			fatalError("Attempting to share a non-existent advice.")
		}
		
		let ac = UIActivityViewController(activityItems: [advice.shareAdvice], applicationActivities: nil)
		ac.popoverPresentationController?.sourceView = sender
		
		present(ac, animated: true)
	}
	
}

private extension ViewController  {
	
	func getAdvice() {
		guard let url = URL(string: "http://fucking-great-advice.ru/api/random") else { return }
		URLSession.shared.dataTask(with: url) { (d, r, err) in
			if let err = err {
				print(err.localizedDescription)
			}
			
			guard let d = d else { return}
			do {
				guard let data = try JSONSerialization.jsonObject(with: d, options: [])
								as? [String: Any], let adviceText = data["text"] as? String else {
					print("error trying to convert data to JSON")
					return
					
				}
				DispatchQueue.main.async {
					self.adviceText = Advice(text: adviceText)
					self.advice.image = self.render(selectedQuote: self.adviceText!)
				}
				print(data)
			} catch  {
				print("error trying to convert data to JSON")
				return
			}
			
		}.resume()
	}
	
	func render(selectedQuote: Advice) -> UIImage {
		let insetAmount: CGFloat = 250
		let drawBounds = advice.bounds.inset(by: UIEdgeInsets(top: insetAmount, left: insetAmount, bottom: insetAmount, right: insetAmount))
		
		var quoteRect = CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
		var fontSize: CGFloat = 14
		var font: UIFont!
		
		var attrs: [NSAttributedString.Key: Any]!
		var str: NSAttributedString!
		
		while true {
			font = UIFont(name: "Noteworthy", size: fontSize)
			attrs = [.font: font!, .foregroundColor: UIColor.purple]
			
			str = NSAttributedString(string: selectedQuote.text, attributes: attrs)
			quoteRect = str.boundingRect(with: CGSize(width: drawBounds.width, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
			
			if quoteRect.height > drawBounds.height {
				fontSize -= 4
			} else {
				break
			}
		}
		
		let format = UIGraphicsImageRendererFormat()
		format.opaque = false
		let renderer = UIGraphicsImageRenderer(bounds: quoteRect.insetBy(dx: -30, dy: -30), format: format)
		
		return renderer.image { ctx in
			for i in 1...5 {
				ctx.cgContext.setShadow(offset: .zero, blur: CGFloat(i) * 2, color: UIColor.black.cgColor)
				str.draw(in: quoteRect)
			}
		}
	}
}
