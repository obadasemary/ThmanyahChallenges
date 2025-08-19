//
//  SearchResultCell.swift
//  ThmanyahChallenges
//
//  Created by Abdelrahman Mohamed on 18.08.2025.
//

import UIKit
import ThmanyahUseCase

final class SearchResultCell: UITableViewCell {
    
    // MARK: - Constants
    static let reuseIdentifier = "SearchResultCell"
    
    // MARK: - UI Components
    private let containerView = UIView()
    private let contentImageView = UIImageView()
    private let contentStackView = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let actionStackView = UIStackView()
    private let durationLabel = UILabel()
    private let actionButtonsStackView = UIStackView()
    private let addToPlaylistButton = UIButton(type: .system)
    private let moreOptionsButton = UIButton(type: .system)
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        // Container view
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        
        // Content image
        contentImageView.contentMode = .scaleAspectFill
        contentImageView.clipsToBounds = true
        contentImageView.layer.cornerRadius = 12
        contentImageView.backgroundColor = .systemGray4
        
        // Content stack view
        contentStackView.axis = .vertical
        contentStackView.spacing = 8
        contentStackView.alignment = .leading
        
        // Title label
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        
        // Description label
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 1
        descriptionLabel.lineBreakMode = .byTruncatingTail
        
        // Action stack view
        actionStackView.axis = .horizontal
        actionStackView.spacing = 16
        actionStackView.alignment = .center
        
        // Duration label
        durationLabel.font = .systemFont(ofSize: 12)
        durationLabel.textColor = .secondaryLabel
        durationLabel.backgroundColor = .systemGray5
        durationLabel.layer.cornerRadius = 6
        durationLabel.textAlignment = .center
        durationLabel.layer.masksToBounds = true
        
        // Action buttons stack view
        actionButtonsStackView.axis = .horizontal
        actionButtonsStackView.spacing = 16
        actionButtonsStackView.alignment = .center
        
        // Add to playlist button
        addToPlaylistButton.setImage(UIImage(systemName: "text.badge.plus"), for: .normal)
        addToPlaylistButton.tintColor = .secondaryLabel
        addToPlaylistButton.addTarget(self, action: #selector(addToPlaylistTapped), for: .touchUpInside)
        
        // More options button
        moreOptionsButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        moreOptionsButton.tintColor = .secondaryLabel
        moreOptionsButton.addTarget(self, action: #selector(moreOptionsTapped), for: .touchUpInside)
        
        // Add subviews
        contentView.addSubview(containerView)
        containerView.addSubview(contentImageView)
        containerView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(descriptionLabel)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(actionStackView)
        
        actionStackView.addArrangedSubview(durationLabel)
        actionStackView.addArrangedSubview(UIView()) // Spacer
        actionStackView.addArrangedSubview(actionButtonsStackView)
        
        actionButtonsStackView.addArrangedSubview(addToPlaylistButton)
        actionButtonsStackView.addArrangedSubview(moreOptionsButton)
    }
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Container view
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            // Content image
            contentImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            contentImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            contentImageView.widthAnchor.constraint(equalToConstant: 80),
            contentImageView.heightAnchor.constraint(equalToConstant: 80),
            
            // Content stack view
            contentStackView.leadingAnchor.constraint(equalTo: contentImageView.trailingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            contentStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            // Duration label
            durationLabel.heightAnchor.constraint(equalToConstant: 20),
            durationLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            // Action buttons
            addToPlaylistButton.widthAnchor.constraint(equalToConstant: 24),
            addToPlaylistButton.heightAnchor.constraint(equalToConstant: 24),
            moreOptionsButton.widthAnchor.constraint(equalToConstant: 24),
            moreOptionsButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    // MARK: - Configuration
    func configure(with result: SearchResult) {
        // Configure title
        titleLabel.text = getTitle(for: result)
        
        // Configure description
        descriptionLabel.text = getDescription(for: result)
        
        // Configure image
        if let imageURL = getImageURL(for: result) {
            loadImage(from: imageURL)
        } else {
            contentImageView.image = UIImage(systemName: "photo")
            contentImageView.tintColor = .systemGray3
        }
        
        // Configure duration
        if let duration = getDuration(for: result) {
            durationLabel.text = formatDuration(duration)
            durationLabel.isHidden = false
        } else {
            durationLabel.isHidden = true
        }
    }
    
    // MARK: - Helper Methods
    private func getTitle(for result: SearchResult) -> String {
        switch result {
        case .podcast(let podcast):
            return podcast.name
        case .episode(let episode):
            return episode.name
        case .audioBook(let book):
            return book.name
        case .audioArticle(let article):
            return article.name
        }
    }
    
    private func getDescription(for result: SearchResult) -> String {
        switch result {
        case .podcast(let podcast):
            return podcast.description ?? "No description available"
        case .episode(let episode):
            return episode.description ?? "No description available"
        case .audioBook(let book):
            return book.description ?? "No description available"
        case .audioArticle(let article):
            return article.description ?? "No description available"
        }
    }
    
    private func getImageURL(for result: SearchResult) -> URL? {
        switch result {
        case .podcast(let podcast):
            return podcast.avatarURL
        case .episode(let episode):
            return episode.avatarURL
        case .audioBook(let book):
            return book.avatarURL
        case .audioArticle(let article):
            return article.avatarURL
        }
    }
    
    private func getDuration(for result: SearchResult) -> TimeInterval? {
        switch result {
        case .podcast(let podcast):
            return podcast.duration
        case .episode(let episode):
            return episode.duration
        case .audioBook(let book):
            return book.duration
        case .audioArticle(let article):
            return article.duration
        }
    }
    
    private func formatDuration(_ duration: TimeInterval) -> String {
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        
        if hours > 0 && minutes > 0 {
            return "\(hours)س \(minutes)د"
        } else if hours > 0 {
            return "\(hours)س"
        } else if minutes > 0 {
            return "\(minutes)د"
        } else {
            return "أقل من دقيقة"
        }
    }
    
    private func loadImage(from url: URL) {
        // Simple image loading - in production you'd use SDWebImage or similar
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self?.contentImageView.image = image
                } else {
                    self?.contentImageView.image = UIImage(systemName: "photo")
                    self?.contentImageView.tintColor = .systemGray3
                }
            }
        }.resume()
    }
    
    // MARK: - Actions
    @objc private func addToPlaylistTapped() {
        // Handle add to playlist action
        print("Add to playlist tapped")
    }
    
    @objc private func moreOptionsTapped() {
        // Handle more options action
        print("More options tapped")
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        contentImageView.image = nil
        titleLabel.text = nil
        descriptionLabel.text = nil
        durationLabel.text = nil
        durationLabel.isHidden = true
    }
}
