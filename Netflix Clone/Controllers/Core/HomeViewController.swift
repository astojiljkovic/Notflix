//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Aleksa Stojiljkovic on 18.3.22..
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
    
    let sectionTitle: [String] = ["Trending movies", "Trending Tv","Popular" , "Upcoming movies", "Top rated" ]
    
    private var randomTrendingMovie: Title?
    private var headerView: HeroHeatherUIView?
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped) // ovde je bitno da stoji grouped sto mi daje isti still kao sto apple koristi
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        //ovako dole moze da se namesti onaj headeru koj ce ici nap pocetna slika
        headerView = HeroHeatherUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        configureNavbar()
        homeFeedTable.tableHeaderView = headerView
        configureHeroHeatherView()
        
//        navigationController?.pushViewController(TitlePreviewViewController(), animated: true)
        
//        getTrendingMovies()
//        getTrendingTv()
//        getUpcomingMovies()
    }
    
    private func configureHeroHeatherView(){
        APICaller.shared.getTrendingMovies {[weak self]result in
            switch result {
            case .success(let titles):
                let selectedTitle = titles.randomElement()
                self?.randomTrendingMovie = selectedTitle
                
                self?.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.original_title ?? "", posterURL: selectedTitle?.poster_path ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureNavbar() {
        var image = UIImage(named: "netflixLogo")
        //bez ove linije dole, logo ce biti plav, i ovo bukvalno mora da se napise kako bi sistem koristio original
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        //stavljanje boje na belo
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
//    private func getTrendingMovies () {
//        APICaller.shared.getTrendingMovies { results in
//            switch results{
//            case .success(let movies):
//                print(movies)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    private func getTrendingTv () {
//        APICaller.shared.getTrendingTvs { results in
//            switch results {
//            case .success(let tv):
//                print(tv)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    private func getUpcomingMovies () {
//        APICaller.shared.getUpcomingMovies { results in
//            switch results {
//            case .success(let movie):
//                print(movie)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//
//    private func getPopularMovies() {
//        APICaller.shared.getPopularMovies { results in
//            switch results {
//            case(.success(let movies)):
//                print(movies)
//            case(.failure(let error)):
//                print(error)
//            }
//        }
//    }
//    private func getTopRatedMovies(){
//        APICaller.shared.getTopRatedMovies { results in
//            switch results{
//            case(.success(let movies)):
//                print(movies)
//            case(.failure(let error)):
//                print(error)
//            }
//        }
//    }

}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    //morali smo da namestimo da imamo ustvari 20 sekcija(redova u tabeli)
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    //i da u svakoj sekciji bude jedan red gde imamo header i red u tabeli
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result{
                case .success(let result):
                    cell.configure(with: result)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrendingTvs { result in
                switch result{
                case .success(let result):
                    cell.configure(with: result)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRatedMovies { result in
                switch result{
                case .success(let result):
                    cell.configure(with: result)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue:
            APICaller.shared.getPopularMovies { result in
                switch result{
                case .success(let result):
                    cell.configure(with: result)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpcomingMovies { result in
                switch result{
                case .success(let result):
                    cell.configure(with: result)
                case.failure(let error):
                    print(error.localizedDescription)
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
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //provera dal postoji header
        guard let header = view as? UITableViewHeaderFooterView else { return}
        //izvlacenje i editovanje texta u headeru ukoliko postoji
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstletter()
        header.textLabel?.textAlignment = .left
    }
    
    //dodavanje iz liste gore navedene za naslove, u header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    
    //namestanje da se navigation bar kad se skroluje na dole, ostane zalepljen i da ode gore kad se skroluje na gore
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0,-offset))
    }
}
extension HomeViewController: CollectionViewTableViewCellDelegate{
    func CollectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
 
    }
}
