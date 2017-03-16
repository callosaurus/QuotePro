//
//  MasterViewController.swift
//  QuotePro
//
//  Created by Callum Davies on 2017-03-15.
//  Copyright © 2017 Callum Davies. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, QuoteBuilderDelegate {

    var arrayOfCompletedQuotes : [CompletedQuote] = []
    var completedQuoteToShow: CompletedQuote?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.makeSampleQuote()
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func makeSampleQuote() {
        let sampleQuote = CompletedQuote()
        sampleQuote.photo.photo = UIImage(named: "forceofnature")!
        sampleQuote.quote.quoteText = "Comparison is the thief of joy"
        sampleQuote.quote.quoteAuthor = "Roosevelt"
        arrayOfCompletedQuotes.append(sampleQuote)
    }
    
    //MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCompletedQuotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath) as! QuoteViewCell
        let selectedQuote = arrayOfCompletedQuotes[indexPath.row]
        cell.completedQuote = selectedQuote
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.completedQuoteToShow = self.arrayOfCompletedQuotes[indexPath.row]
        self.performSegue(withIdentifier: "goToQuoteBuilder", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            arrayOfCompletedQuotes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "goToQuoteBuilder", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var builderVC = QuoteBuilderViewController()
        builderVC = segue.destination as! QuoteBuilderViewController
        builderVC.delegate = self
        if sender is UIBarButtonItem {
            let emptyCompletedQuote = CompletedQuote()
            emptyCompletedQuote.photo.photo = UIImage(named: "1screen")!
            emptyCompletedQuote.quote.quoteText = ""
            emptyCompletedQuote.quote.quoteAuthor = ""
            
            builderVC.completedQuote = emptyCompletedQuote
        } else {
            builderVC.completedQuote = self.completedQuoteToShow
        }
    }
    
    func saveQuote(quoteToBeSaved: CompletedQuote) {
        arrayOfCompletedQuotes.append(quoteToBeSaved)
    }
}

