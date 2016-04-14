//
//  BTConfiguration.swift
//  BTNavigationDropdownMenu
//
//  Created by Pham Ba Tho on 6/30/15.
//  Copyright (c) 2015 PHAM BA THO. All rights reserved.
//

//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

// MARK: BTNavigationDropdownMenu
public class BTNavigationDropdownMenu: UIView {
    
    // The color of menu title. Default is darkGrayColor()
    public var menuTitleColor: UIColor! {
        get {
            return self.configuration.menuTitleColor
        }
        set(value) {
            self.configuration.menuTitleColor = value
        }
    }
    
    // The font of menu title.
    public var menuTitleFont: UIFont! {
        get {
            return self.configuration.menuTitleFont
        }
        set(value) {
            self.configuration.menuTitleFont = value
            self.menuTitle.font = value
        }
    }
    
    // The height of the cell. Default is 50
    public var cellHeight: CGFloat! {
        get {
            return self.configuration.cellHeight
        }
        set(value) {
            self.configuration.cellHeight = value
        }
    }
    
    // The color of the cell background. Default is whiteColor()
    public var cellBackgroundColor: UIColor! {
        get {
            return self.configuration.cellBackgroundColor
        }
        set(color) {
            self.configuration.cellBackgroundColor = color
        }
    }
    
    public var cellSeparatorColor: UIColor! {
        get {
            return self.configuration.cellSeparatorColor
        }
        set(value) {
            self.configuration.cellSeparatorColor = value
        }
    }
    
    // The color of the text inside cell. Default is darkGrayColor()
    public var cellTextLabelColor: UIColor! {
        get {
            return self.configuration.cellTextLabelColor
        }
        set(value) {
            self.configuration.cellTextLabelColor = value
        }
    }
   
    public var cellTextLabelSelectedColor: UIColor! {
        get {
            return self.configuration.cellTextLabelSelectedColor
        }
        set(value) {
            self.configuration.cellTextLabelSelectedColor = value
        }
    }
    
    // The font of the text inside cell. Default is HelveticaNeue-Bold, size 19
    public var cellTextLabelFont: UIFont! {
        get {
            return self.configuration.cellTextLabelFont
        }
        set(value) {
            self.configuration.cellTextLabelFont = value
        }
    }
    
    // The alignment of the text inside cell. Default is .Left
    public var cellTextLabelAlignment: NSTextAlignment! {
        get {
            return self.configuration.cellTextLabelAlignment
        }
        set(value) {
            self.configuration.cellTextLabelAlignment = value
        }
    }
    
    // The color of the cell when the cell is selected. Default is lightGrayColor()
    public var cellSelectionColor: UIColor! {
        get {
            return self.configuration.cellSelectionColor
        }
        set(value) {
            self.configuration.cellSelectionColor = value
        }
    }
    
    // The checkmark icon of the cell
    public var checkMarkImage: UIImage! {
        get {
            return self.configuration.checkMarkImage
        }
        set(value) {
            self.configuration.checkMarkImage = value
        }
    }
    
    public var checkMarkEnabled: Bool! {
        get {
            return self.configuration.checkMarkEnabled
        }
        set {
            self.configuration.checkMarkEnabled = newValue
        }
    }
    
    // The animation duration of showing/hiding menu. Default is 0.3
    public var animationDuration: NSTimeInterval! {
        get {
            return self.configuration.animationDuration
        }
        set(value) {
            self.configuration.animationDuration = value
        }
    }

    // The arrow next to navigation title
    public var arrowImage: UIImage! {
        get {
            return self.configuration.arrowImage
        }
        set(value) {
            self.configuration.arrowImage = value
            self.menuArrow.image = self.configuration.arrowImage
        }
    }
    
    public var expandArrowImage: UIImage! {
        get {
            return self.configuration.expandArrowImage
        }
        set {
            self.configuration.expandArrowImage = newValue
        }
    }
    
    public var menuArrowPosition: BTPosition! {
        get {
            return self.configuration.menuArrowPosition
        }
        set {
            self.configuration.menuArrowPosition = newValue
        }
    }
    
    // The padding between navigation title and arrow
    public var arrowPadding: CGFloat! {
        get {
            return self.configuration.arrowPadding
        }
        set(value) {
            self.configuration.arrowPadding = value
        }
    }
    
    // The color of the mask layer. Default is blackColor()
    public var maskBackgroundColor: UIColor! {
        get {
            return self.configuration.maskBackgroundColor
        }
        set(value) {
            self.configuration.maskBackgroundColor = value
        }
    }
    
    // The opacity of the mask layer. Default is 0.3
    public var maskBackgroundOpacity: CGFloat! {
        get {
            return self.configuration.maskBackgroundOpacity
        }
        set(value) {
            self.configuration.maskBackgroundOpacity = value
        }
    }
    
    public var defaultExpandSections: [Int]? {
        get {
            return self.configuration.defaultExpandSections
        }
        set {
            self.configuration.defaultExpandSections = newValue
        }
    }
    
    public var title: String {
        didSet {
            setMenuTitle(title)
        }
    }
    
    public var items: [[String]] {
        didSet {
            self.tableView.items = items
        }
    }
    
    public var enabled: Bool = true {
        didSet {
            if self.isShown ?? true {
                hideMenu()
            }
            layoutSubviews()
        }
    }
    
    public var didSelectItemAtIndexHandler: ((indexPath: NSIndexPath) -> ())?
    public var isShown: Bool!

    private var navigationController: UINavigationController?
    private var configuration = BTConfiguration()
    private var topSeparator: UIView!
    private var menuButton: UIButton!
    private var menuTitle: UILabel!
    private var menuArrow: UIImageView!
    private var backgroundView: UIView!
    private var tableView: BTTableView!
    private var menuWrapper: UIView!
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @available(*, deprecated, message="Use init(navigationController:title:items:) instead", renamed="BTNavigationDropdownMenu(navigationController: UINavigationController?, title: String, items: [AnyObject])")
    public convenience init(title: String, items: [[String]]) {
        self.init(navigationController: nil, title: title, items: items)
    }
    
    // use items1 because of oc compability
    public convenience init(navigationController: UINavigationController?, title: String, items1: [String]) {
        let items = items1.map { [$0] }
        self.init(navigationController: navigationController, title: title, items: items)
    }
    
    public convenience init(navigationController: UINavigationController?, title: String, items1: [String], configuration: BTConfiguration) {
        let items = items1.map { [$0] }
        self.init(navigationController: navigationController, title: title, items: items, configuration: configuration)
    }
    
    public convenience init(navigationController: UINavigationController?, title: String, items: [[String]]) {
        self.init(navigationController: navigationController, title: title, items: items, configuration: BTConfiguration())
    }
    
    public init(navigationController: UINavigationController?, title: String, items: [[String]], configuration: BTConfiguration) {
        // Navigation controller
        if let navigationController = navigationController {
            self.navigationController = navigationController
        } else {
            self.navigationController = UIApplication.sharedApplication().keyWindow?.rootViewController?.topMostViewController?.navigationController
        }
        
        // Get titleSize
        let titleSize = (title as NSString).sizeWithAttributes([NSFontAttributeName:self.configuration.cellTextLabelFont])
       
        self.title = title
        self.isShown = false
        self.items = items
        
        // Set frame
        let frame = CGRectMake(0, 0, titleSize.width + (self.configuration.arrowPadding + self.configuration.arrowImage.size.width)*2, self.navigationController!.navigationBar.frame.height)
        
        super.init(frame:frame)
        
        self.navigationController?.view.addObserver(self, forKeyPath: "frame", options: .New, context: nil)
        
        
        // Init properties
        self.configuration = configuration

        // Init button as navigation title
        self.menuButton = UIButton(frame: frame)
        self.menuButton.addTarget(self, action: "menuButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(self.menuButton)
        
        self.menuTitle = UILabel(frame: frame)
        self.menuTitle.text = title
        self.menuTitle.textColor = self.menuTitleColor
        self.menuTitle.font = self.configuration.menuTitleFont
        self.menuTitle.textAlignment = self.configuration.cellTextLabelAlignment
        self.menuButton.addSubview(self.menuTitle)
        
        self.menuArrow = UIImageView(image: self.configuration.arrowImage)
        self.menuButton.addSubview(self.menuArrow)
        
        let window = UIApplication.sharedApplication().keyWindow!
        let menuWrapperBounds = window.bounds
        
        // Set up DropdownMenu
        self.menuWrapper = UIView(frame: CGRectMake(menuWrapperBounds.origin.x, 0, menuWrapperBounds.width, menuWrapperBounds.height))
        self.menuWrapper.clipsToBounds = true
        self.menuWrapper.autoresizingMask = UIViewAutoresizing.FlexibleWidth.union(UIViewAutoresizing.FlexibleHeight)
        
        // Init background view (under table view)
        self.backgroundView = UIView(frame: menuWrapperBounds)
        self.backgroundView.backgroundColor = self.configuration.maskBackgroundColor
        self.backgroundView.autoresizingMask = UIViewAutoresizing.FlexibleWidth.union(UIViewAutoresizing.FlexibleHeight)
        
        let backgroundTapRecognizer = UITapGestureRecognizer(target: self, action: "hideMenu");
        self.backgroundView.addGestureRecognizer(backgroundTapRecognizer)
        
        // Init table view
        // 300 for header and 64 for nav and status bar height
        self.tableView = BTTableView(frame: CGRectMake(menuWrapperBounds.origin.x, menuWrapperBounds.origin.y + 0.5, menuWrapperBounds.width, menuWrapperBounds.height + 300 - 64), items: items, configuration: self.configuration)
        
        self.tableView.selectRowAtIndexPathHandler = { (indexPath: NSIndexPath) -> () in
            self.didSelectItemAtIndexHandler?(indexPath: indexPath)
            self.hideMenu()
            self.layoutSubviews()
        }
        
        // Add background view & table view to container view
        self.menuWrapper.addSubview(self.backgroundView)
        self.menuWrapper.addSubview(self.tableView)
        
        // Add Line on top
        self.topSeparator = UIView(frame: CGRectMake(0, 0, menuWrapperBounds.size.width, 0.5))
        self.topSeparator.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.menuWrapper.addSubview(self.topSeparator)
        
        // Add Menu View to container view
        window.addSubview(self.menuWrapper)
        
        // By default, hide menu view
        self.menuWrapper.hidden = true
    }
    
    public override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            // Set up DropdownMenu
            self.menuWrapper.frame.origin.y = self.navigationController!.navigationBar.frame.maxY
            self.tableView.reloadData()
        }
    }
    
    override public func layoutSubviews() {
        self.menuTitle.sizeToFit()
        self.menuTitle.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        
        self.menuArrow.hidden = !self.enabled
        self.menuArrow.sizeToFit()
        switch self.menuArrowPosition! {
        case .Bottom:
            self.menuArrow.center = CGPointMake(self.menuTitle.frame.origin.x + self.menuTitle.frame.width / 2, self.frame.size.height - self.menuArrow.frame.height)
        default:
            self.menuArrow.center = CGPointMake(CGRectGetMaxX(self.menuTitle.frame) + self.configuration.arrowPadding, self.frame.size.height/2)
        }
    }
    
    public func show() {
        if self.isShown == false {
            self.showMenu()
        }
    }
    
    public func hide() {
        if self.isShown == true {
            self.hideMenu()
        }
    }
    
    func setupDefaultConfiguration() {
        self.menuTitleColor = self.navigationController?.navigationBar.titleTextAttributes?[NSForegroundColorAttributeName] as? UIColor // Setter
        self.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        self.cellSeparatorColor = self.navigationController?.navigationBar.titleTextAttributes?[NSForegroundColorAttributeName] as? UIColor
        self.cellTextLabelColor = self.navigationController?.navigationBar.titleTextAttributes?[NSForegroundColorAttributeName] as? UIColor
    }
    
    
    func showMenu() {
        self.menuWrapper.frame.origin.y = self.navigationController!.navigationBar.frame.maxY
        
        self.isShown = true
        
        // Table view header
        let headerView = UIView(frame: CGRectMake(0, 0, self.frame.width, 300))
        headerView.backgroundColor = self.configuration.cellBackgroundColor
        self.tableView.tableHeaderView = headerView
        
        self.topSeparator.backgroundColor = self.configuration.cellSeparatorColor
        
        // Rotate arrow
        self.rotateArrow()
        
        // Visible menu view
        self.menuWrapper.hidden = false
        
        // Change background alpha
        self.backgroundView.alpha = 0
        
        // Animation
        self.tableView.frame.origin.y = -self.tableView.contentSize.height - 300
        
        // Reload data to dismiss highlight color of selected cell
        self.tableView.reloadData()
        
        self.menuWrapper.superview?.bringSubviewToFront(self.menuWrapper)
        
        UIView.animateWithDuration(
            self.configuration.animationDuration * 1.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: [],
            animations: {
                self.tableView.frame.origin.y = CGFloat(-300)
                self.backgroundView.alpha = self.configuration.maskBackgroundOpacity
            }, completion: nil
        )
    }
    
    func hideMenu() {
        // Rotate arrow
        self.rotateArrow()
        
        self.isShown = false
        
        // Change background alpha
        self.backgroundView.alpha = self.configuration.maskBackgroundOpacity
        
        UIView.animateWithDuration(
            self.configuration.animationDuration * 1.5,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: [],
            animations: {
                self.tableView.frame.origin.y = CGFloat(-200)
            }, completion: nil
        )
        
        // Animation
        UIView.animateWithDuration(self.configuration.animationDuration, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: {
            self.tableView.frame.origin.y = -self.tableView.contentSize.height - 300
            self.backgroundView.alpha = 0
            }, completion: { _ in
                self.menuWrapper.hidden = true
        })
    }
    
    func rotateArrow() {
        UIView.animateWithDuration(self.configuration.animationDuration, animations: {[weak self] () -> () in
            if let selfie = self {
                selfie.menuArrow.transform = CGAffineTransformRotate(selfie.menuArrow.transform, 180 * CGFloat(M_PI/180))
            }
            })
    }
    
    func setMenuTitle(title: String) {
        self.menuTitle.text = title
        self.layoutSubviews()
    }
    
    func menuButtonTapped(sender: UIButton) {
        if self.enabled {
            self.isShown == true ? hideMenu() : showMenu()
        }
    }
}

public enum BTPosition {
    case Right
    case Bottom
}

// MARK: BTConfiguration
public class BTConfiguration {
    public var menuTitleFont: UIFont!
    public var menuTitleColor: UIColor?
    public var cellHeight: CGFloat!
    public var cellBackgroundColor: UIColor?
    public var cellSeparatorColor: UIColor?
   
    public var cellTitleLabelColor: UIColor?
    public var cellTitleLabelFont: UIFont!
    public var cellTitleLabelAlignment: NSTextAlignment!
    
    public var cellTextLabelColor: UIColor?
    public var cellTextLabelSelectedColor: UIColor?
    public var cellTextLabelFont: UIFont!
    public var cellTextLabelAlignment: NSTextAlignment!
    
    public var cellSelectionColor: UIColor?
    public var checkMarkImage: UIImage!
    public var checkMarkEnabled: Bool!
    public var arrowImage: UIImage!
    public var menuArrowPosition: BTPosition!
    public var expandArrowImage: UIImage!
    public var arrowPadding: CGFloat!
    public var animationDuration: NSTimeInterval!
    public var maskBackgroundColor: UIColor!
    public var maskBackgroundOpacity: CGFloat!
    public var defaultExpandSections: [Int]?
    
    public weak var customTableViewDelegate: UITableViewDelegate?
    public weak var customTableViewDatasource: UITableViewDataSource?
    
    public init() {
        // Path for image
        let bundle = NSBundle(forClass: BTConfiguration.self)
        let url = bundle.URLForResource("BTNavigationDropdownMenu", withExtension: "bundle")
        let imageBundle = NSBundle(URL: url!)
        let checkMarkImagePath = imageBundle?.pathForResource("checkmark_icon", ofType: "png")
        let arrowImagePath = imageBundle?.pathForResource("arrow_down_icon", ofType: "png")

        // Default values
        self.menuTitleColor = UIColor.darkGrayColor()
        self.menuTitleFont = UIFont(name: "HelveticaNeue-Bold", size: 17)
        self.cellHeight = 50
        self.cellBackgroundColor = UIColor.whiteColor()
        self.cellSeparatorColor = UIColor.darkGrayColor()
        
        self.cellTextLabelColor = UIColor.darkGrayColor()
        self.cellTextLabelSelectedColor = UIColor.blackColor()
        self.cellTextLabelFont = UIFont(name: "HelveticaNeue-Bold", size: 17)
        self.cellTextLabelAlignment = NSTextAlignment.Left
        
        self.cellTitleLabelColor = UIColor.darkGrayColor()
        self.cellTitleLabelFont = UIFont(name: "HelveticaNeue-Bold", size: 17)
        self.cellTitleLabelAlignment = NSTextAlignment.Left
        
        self.cellSelectionColor = UIColor.lightGrayColor()
        self.checkMarkImage = UIImage(contentsOfFile: checkMarkImagePath!)
        self.animationDuration = 0.5
        self.arrowImage = UIImage(contentsOfFile: arrowImagePath!)
        self.expandArrowImage = self.arrowImage
        self.menuArrowPosition = .Right
        self.arrowPadding = 15
        self.maskBackgroundColor = UIColor.blackColor()
        self.maskBackgroundOpacity = 0.3
        self.checkMarkEnabled = true
    }
}

// MARK: Table View
class BTTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    // Public properties
    var configuration: BTConfiguration
    var selectRowAtIndexPathHandler: ((indexPath: NSIndexPath) -> ())?
    
    var items: [[String]] {
        didSet {
            while items.count > sectionExpansion.count {
                sectionExpansion.append(false)
            }
            reloadData()
        }
    }
    
    // Private properties
    private var selectedIndexPath: NSIndexPath
    private var sectionExpansion: [Bool]
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, items: [String], configuration: BTConfiguration) {
        let items = items.map { [$0] }
        self.init(frame: frame, items:items, configuration: configuration)
    }
    
    init(frame: CGRect, items: [[String]], configuration: BTConfiguration) {
        self.items = items
        self.configuration = configuration
        self.selectedIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.sectionExpansion = self.items.indices.map { configuration.defaultExpandSections?.contains($0) ?? false }
        
        super.init(frame: frame, style: UITableViewStyle.Plain)
        
        // Setup table view
        if let delegate = self.configuration.customTableViewDelegate {
            self.delegate = self.configuration.customTableViewDelegate
        } else {
            self.delegate = self
        }
        if let dataSource = self.configuration.customTableViewDatasource {
            self.dataSource = dataSource
        } else {
            self.dataSource = self
        }
        self.backgroundColor = UIColor.clearColor()
        self.separatorStyle = UITableViewCellSeparatorStyle.None
        self.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.tableFooterView = UIView(frame: CGRectZero)
    }
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        if let hitView = super.hitTest(point, withEvent: event)
            where hitView.isKindOfClass(BTTableCellContentView.self) || hitView.isKindOfClass(UIImageView.self) {
            return hitView
        }
        return nil;
    }
    
    // Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionExpansion[section] ? self.items[section].count : 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.configuration.cellHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: BTTableViewCell
        if indexPath.row == 0 {
            cell = BTTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Header", cellType: .Header, configuration: self.configuration)
        } else {
            cell = BTTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Item", cellType: .Item, configuration: self.configuration)
        }
        cell.textLabel?.text = self.items[indexPath.section][indexPath.row] as? String
        cell.selected = selectedIndexPath == indexPath
        
        cell.checkmarkIcon.hidden = self.configuration.checkMarkEnabled && (indexPath == selectedIndexPath) ? false : true
        let showExpansion = self.items[indexPath.section].count > 1 && indexPath.row == 0
        cell.expandArrowIcon.hidden = !showExpansion
        
        if showExpansion {
            cell.expansionTapAction = { [weak self] in
                if let selfie = self {
                    let expand = !selfie.sectionExpansion[indexPath.section]
                    selfie.sectionExpansion[indexPath.section] = expand
                    let count = selfie.items[indexPath.section].count
                    let indexPaths = Array(1..<count).map { NSIndexPath(forRow: $0, inSection: indexPath.section) }
                    if expand {
                        selfie.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                    } else {
                        selfie.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                    }
                }
            }
        }
        
        return cell
    }
    
    // Table view delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndexPath = indexPath
        self.selectRowAtIndexPathHandler!(indexPath: indexPath)
        self.reloadData()
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? BTTableViewCell
        cell?.contentView.backgroundColor = self.configuration.cellSelectionColor
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? BTTableViewCell
        cell?.checkmarkIcon.hidden = true
        cell?.contentView.backgroundColor = self.configuration.cellBackgroundColor
    }
}

enum CellType {
    case Header
    case Item
}

// MARK: Table view cell
class BTTableViewCell: UITableViewCell {
    let checkmarkIconWidth: CGFloat = 50
    let horizontalMargin: CGFloat = 20
    
    var checkmarkIcon: UIImageView!
    var expandArrowIcon: UIImageView!
    var cellContentFrame: CGRect!
    var configuration: BTConfiguration!
    var expansionTapAction: (() -> Void)? = nil
    var type: CellType
    
    override var selected: Bool {
        didSet {
            self.textLabel!.textColor = selected ?
                self.configuration.cellTextLabelSelectedColor :
                type == .Header ? self.configuration.cellTitleLabelColor : self.configuration.cellTextLabelColor
        }
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, cellType: CellType, configuration: BTConfiguration) {
        type = cellType
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configuration = configuration
        
        // Setup cell
        cellContentFrame = CGRectMake(0, 0, (UIApplication.sharedApplication().keyWindow?.frame.width)!, self.configuration.cellHeight)
        self.contentView.backgroundColor = self.configuration.cellBackgroundColor
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        if cellType == .Header {
            self.textLabel!.textColor = self.configuration.cellTitleLabelColor
            self.textLabel!.font = self.configuration.cellTitleLabelFont
            self.textLabel!.textAlignment = self.configuration.cellTitleLabelAlignment
        } else {
            self.textLabel!.textColor = self.configuration.cellTextLabelColor
            self.textLabel!.font = self.configuration.cellTextLabelFont
            self.textLabel!.textAlignment = self.configuration.cellTextLabelAlignment
        }
        
        if self.textLabel!.textAlignment == .Center {
            self.textLabel!.frame = CGRectMake(0, 0, cellContentFrame.width, cellContentFrame.height)
        } else if self.textLabel!.textAlignment == .Left {
            self.textLabel!.frame = CGRectMake(horizontalMargin, 0, cellContentFrame.width, cellContentFrame.height)
        } else {
            self.textLabel!.frame = CGRectMake(-horizontalMargin, 0, cellContentFrame.width, cellContentFrame.height)
        }
        
        // Checkmark icon
        if self.textLabel!.textAlignment == .Center {
            self.checkmarkIcon = UIImageView(frame: CGRectMake(cellContentFrame.width - checkmarkIconWidth, (cellContentFrame.height - 30)/2, 30, 30))
        } else if self.textLabel!.textAlignment == .Left {
            self.checkmarkIcon = UIImageView(frame: CGRectMake(cellContentFrame.width - checkmarkIconWidth, (cellContentFrame.height - 30)/2, 30, 30))
        } else {
            self.checkmarkIcon = UIImageView(frame: CGRectMake(horizontalMargin, (cellContentFrame.height - 30)/2, 30, 30))
        }
        self.checkmarkIcon.hidden = true
        self.checkmarkIcon.image = self.configuration.checkMarkImage
        self.checkmarkIcon.contentMode = UIViewContentMode.ScaleAspectFill
        self.contentView.addSubview(self.checkmarkIcon)
       
        // Separator for cell
        let separator = BTTableCellContentView(frame: cellContentFrame)
        if let cellSeparatorColor = self.configuration.cellSeparatorColor {
            separator.separatorColor = cellSeparatorColor
        }
        self.contentView.addSubview(separator)
        
        // expansion icon
        self.expandArrowIcon = UIImageView(frame: CGRectMake(cellContentFrame.width - 40, cellContentFrame.origin.y, 40, cellContentFrame.height))
        self.expandArrowIcon.hidden = true
        self.expandArrowIcon.image = self.configuration.expandArrowImage
        self.expandArrowIcon.contentMode = .Center
        self.contentView.addSubview(self.expandArrowIcon)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(expansionTap))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.cancelsTouchesInView = true
        self.expandArrowIcon.addGestureRecognizer(tapRecognizer)
        self.expandArrowIcon.userInteractionEnabled = true
    }
    
    @objc private func expansionTap(sender: UITapGestureRecognizer) {
        self.expansionTapAction?()
        self.rotateArrow(self.expandArrowIcon)
    }
    
    func rotateArrow(arrowView: UIImageView) {
        UIView.animateWithDuration(0.2, animations: {[weak self] () -> () in
            arrowView.transform = CGAffineTransformRotate(arrowView.transform, 180 * CGFloat(M_PI/180))
            })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.bounds = cellContentFrame
        self.contentView.frame = self.bounds
    }
}

// Content view of table view cell
class BTTableCellContentView: UIView {
    var separatorColor: UIColor = UIColor.blackColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialize()
    }
    
    func initialize() {
        self.backgroundColor = UIColor.clearColor()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let context = UIGraphicsGetCurrentContext()
        
        // Set separator color of dropdown menu based on barStyle
        CGContextSetStrokeColorWithColor(context, self.separatorColor.CGColor)
        CGContextSetLineWidth(context, 1)
        CGContextMoveToPoint(context, 0, self.bounds.size.height)
        CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height)
        CGContextStrokePath(context)
    }
}

extension UIViewController {
    // Get ViewController in top present level
    var topPresentedViewController: UIViewController? {
        var target: UIViewController? = self
        while (target?.presentedViewController != nil) {
            target = target?.presentedViewController
        }
        return target
    }
    
    // Get top VisibleViewController from ViewController stack in same present level.
    // It should be visibleViewController if self is a UINavigationController instance
    // It should be selectedViewController if self is a UITabBarController instance
    var topVisibleViewController: UIViewController? {
        if let navigation = self as? UINavigationController {
            if let visibleViewController = navigation.visibleViewController {
                return visibleViewController.topVisibleViewController
            }
        }
        if let tab = self as? UITabBarController {
            if let selectedViewController = tab.selectedViewController {
                return selectedViewController.topVisibleViewController
            }
        }
        return self
    }
    
    // Combine both topPresentedViewController and topVisibleViewController methods, to get top visible viewcontroller in top present level
    var topMostViewController: UIViewController? {
        return self.topPresentedViewController?.topVisibleViewController
    }
}
