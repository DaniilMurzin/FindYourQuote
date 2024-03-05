import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var categories = Categories.availableCategories
    private var filteredQuotesArray = [String]()
    private var isFiltering: Bool  {
        searchController.isActive && !searchBarIsEmpty
    }
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let element = UITableView()
        element.delegate = self
        element.dataSource = self
        element.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return element
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        setupUI()
        setupConstraints()
    }
    // MARK: - Private funcs
    
    private func setupUI(){
        
        view.addSubview(tableView)
    }
    
    private func goToResultViewController() {
        let resultVC = ResultViewController()
        self.navigationController?.present(resultVC, animated: true)
    }
    
}

// MARK: - Setup Constraints
extension SearchViewController {
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - SearchViewController + UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
   
    func updateSearchResults(for searchController: UISearchController) {
       filteredContentForSearchText(searchController.searchBar.text!)
    }
    
    private func setupSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation
        = false
        searchController.searchBar.placeholder = "Введите цитату"
        navigationItem.hidesSearchBarWhenScrolling  = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func filteredContentForSearchText(_ searchText: String ) {
        
        filteredQuotesArray = categories.filter({ category in
            category.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
}
// MARK: - SearchViewController + UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToResultViewController()
    }
}

// MARK: - SearchViewController + UITableViewDataSource
extension SearchViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredQuotesArray.count
        }
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let category: String
        
        if isFiltering {
            category =  filteredQuotesArray[indexPath.row]
        } else {
            category = categories[indexPath.row]
        }
        
        cell.textLabel?.text = category
        return cell
        
    }
}
