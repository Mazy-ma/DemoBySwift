//
//  TempViewController.swift
//  CollectionViewTransitions
//
//  Created by Mazy on 2017/12/29.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.green
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }

}
