//
//  ViewController.swift
//  Thoughts
//
//  Created by Pham Toan on 19/07/2022.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    let sectionTitles: [String] = ["Trending Movies", "Trending Tv", "Popular", "Upcoming Movies", "Top rated"]

    private let homeFeedTable : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavbar()
        
        let headerView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func configureNavbar(){
        var image = UIImage(named: "nlogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName:"person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName:"play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }


}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier,for: indexPath) as? CollectionViewTableViewCell
        else {
            return UITableViewCell()
        }


    switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
                APICaller.shared.getTrendingMovies { results in
                    switch results {
                    case .success( let movies ):
                        cell.configure(with: movies)
                        print("LOG:123 \(movies[0])")
                    case .failure(let error):
                        print("LOG: \(error)")
                    }
                }
            
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrendingTvs { results in
                switch results {
                case .success( let movies ):
                    cell.configure(with: movies)
                    print("LOG:123 \(movies[0])")
                case .failure(let error):
                    print("LOG: \(error)")
                }
            }
        case Sections.Popular.rawValue:
            APICaller.shared.getPopular { results in
                switch results {
                case .success( let movies ):
                    cell.configure(with: movies)
                    print("LOG:123 \(movies[0])")

                case .failure(let error):
                    print("LOG: \(error)")
                }
            }
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpcomingMovies { results in
                switch results {
                case .success( let movies ):
                    cell.configure(with: movies)
                    print("LOG:123 \(movies[0])")

                case .failure(let error):
                    print("LOG: \(error)")
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRate { results in
                switch results {
                case .success( let movies ):
                    cell.configure(with: movies)
                    print("LOG:123 \(movies[0])")

                case .failure(let error):
                    print("LOG: \(error)")
                }
            }
        default:
        return UITableViewCell()
        
    }
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        // truoc khi show header
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitaizeFirstLetter()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
//        print("LOG: defaultOffset \(offset)")
//        print("LOG: offset \(offset)")
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
}
