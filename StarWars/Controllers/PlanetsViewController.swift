//
//  PlanetsViewController.swift
//  StarWars
//
//  Created by Ahamed Shimak on 2022-05-25.
//

import UIKit

import RxSwift
import RxCocoa

class PlanetsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private let planets: BehaviorRelay<[PlanetViewModel]> = BehaviorRelay(value: [])
    private var selectedPlanet: PlanetViewModel? = nil
    private var page: Int = 1
    private var maxPlanets: Int = 0
    
    private let bag: DisposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bind()
        fetchData()
    }
    
    // MARK: - Configurations
    
    private func configureTableView() {
        tableView.register(
            UINib(nibName: "PlanetInfoTableViewCell", bundle: .main),
            forCellReuseIdentifier: PlanetInfoTableViewCell.defaultReuseIdentifier
        )
    }
    
    // MARK: - Bindings
    
    private func bind() {
        planets.observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(
                cellIdentifier: PlanetInfoTableViewCell.defaultReuseIdentifier,
                cellType: PlanetInfoTableViewCell.self
            )) { index, model, cell in
                cell.configure(with: model)
            }.disposed(by: bag)
        
        tableView.rx.modelSelected(PlanetViewModel.self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] planetViewModel in
                self?.selectedPlanet = planetViewModel
                self?.performSegue(withIdentifier: "planetDetail", sender: self)
            }).disposed(by: bag)
        
        tableView.rx.willDisplayCell
            .filter { self.hasReachFinalPlanet(row: $0.indexPath.row) }
            .subscribe(onNext: { [weak self] _ in
                self?.fetchData()
            }).disposed(by: bag)
    }
    
    // MARK: - API call
    
    private func fetchData() {
        let page = page == 1 ? nil : "\(page)"
        PlanetService.getPlanets(page: page) { [weak self] (result: Result<GetPlanetsResponse, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let planets = response.results.map { PlanetViewModel(model: Planet(response: $0)) }
                self.planets.accept(self.planets.value + planets)
                self.page += 1
                self.maxPlanets = response.count
            case .failure(let error):
                self.showMessage(title: "Error", message: error.localizedDescription)
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? PlanetDetailViewController,
              let selectedPlanet = selectedPlanet else {
                  return
        }
        
        controller.viewModel = selectedPlanet
    }
    
    // MARK: -
    
    private func hasReachFinalPlanet(row: Int) -> Bool {
        return planets.value.count - 1 < self.maxPlanets && row == self.planets.value.count - 1
    }
}
