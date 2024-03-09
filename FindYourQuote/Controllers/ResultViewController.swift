import UIKit
import SnapKit

class ResultViewController: UIViewController {

    private var quoteLabelText: String
    private var authorLabelText: String
    
    init(quoteLabelText: String, authorLabelText: String) {
        self.quoteLabelText = quoteLabelText
        self.authorLabelText = authorLabelText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var quoteLabel: UILabel = {
        let element = UILabel()
        element.text = quoteLabelText
        element.font = .systemFont(ofSize: 34)
        element.numberOfLines = 0
        return element
    }()
    
    
    private lazy var authorLabel: UILabel = {
        let element = UILabel()
        element.text = authorLabelText
        element.font = .systemFont(ofSize: 24)
        element.numberOfLines = 0
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        view.addSubview(authorLabel)
        view.addSubview(quoteLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalTo(view.snp.centerX)
            make.left.greaterThanOrEqualTo(view.snp.left).offset(20)
            make.right.lessThanOrEqualTo(view.snp.right).offset(-20)
        }
        quoteLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(20)
            make.centerX.equalTo(authorLabel.snp.centerX)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
        }
    }
}
