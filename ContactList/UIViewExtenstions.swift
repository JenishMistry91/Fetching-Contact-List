//
//  UIViewExtenstions.swift
//  Astryve
//
//  Created by Jeet Dholakia on 8/21/19.
//  Copyright © 2019 Finablr Peaas. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    var width:      CGFloat { return self.frame.size.width }
    var height:     CGFloat { return self.frame.size.height }
    var size:       CGSize  { return self.frame.size}
    
    var origin:     CGPoint { return self.frame.origin }
    var x:          CGFloat { return self.frame.origin.x }
    var y:          CGFloat { return self.frame.origin.y }
    var centerX:    CGFloat { return self.center.x }
    var centerY:    CGFloat { return self.center.y }
    
    var left:       CGFloat { return self.frame.origin.x }
    var right:      CGFloat { return self.frame.origin.x + self.frame.size.width }
    var top:        CGFloat { return self.frame.origin.y }
    var bottom:     CGFloat { return self.frame.origin.y + self.frame.size.height }
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func setSize(_ size:CGSize)
    {
        self.frame.size = size
    }
    
    func setOrigin(_ point:CGPoint)
    {
        self.frame.origin = point
    }
    
    func setX(_ x:CGFloat) //only change the origin x
    {
        self.frame.origin = CGPoint(x: x, y: self.frame.origin.y)
    }
    
    func setY(_ y:CGFloat) //only change the origin x
    {
        self.frame.origin = CGPoint(x: self.frame.origin.x, y: y)
    }
    
    func roundCorner(_ radius:CGFloat)
    {
        self.layer.cornerRadius = radius
    }
    
    func setTop(_ top:CGFloat)
    {
        self.frame.origin.y = top
    }
    
    func setLeft(_ left:CGFloat)
    {
        self.frame.origin.x = left
    }
    
    func setRight(_ right:CGFloat)
    {
        self.frame.origin.x = right - self.frame.size.width
    }
    
    func setBottom(_ bottom:CGFloat)
    {
        self.frame.origin.y = bottom - self.frame.size.height
    }
    
    func isTextControl() -> Bool{
        return (self.isTextFieldControl() || self.isTextViewControl())
    }
    
    func isTextFieldControl() -> Bool{
        return self.isKind(of: UITextField.self)
    }
    
    func isTextViewControl() -> Bool{
        return self.isKind(of: UITextView.self)
    }
    
    
    func setBorder(_ borderColor: UIColor, width: CGFloat, radius: CGFloat){
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = radius
        
    }
    
    func setTopBorder(_ borderColor: UIColor, width: CGFloat) {
        
        let layerName: String = "upper_layer"
        var upperBorder: CALayer?
        
        for layer: CALayer in self.layer.sublayers!{
            if layer.name == layerName {
                upperBorder = layer
                break
            }
        }
        
        if(upperBorder == nil){
            upperBorder = CALayer()
        }
        
        upperBorder!.name = layerName
        upperBorder!.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 1.0)
        
        upperBorder!.borderWidth = width
        upperBorder!.borderColor = borderColor.cgColor
        
        self.layer.addSublayer(upperBorder!)
    }
    
    func setBottomBorder(_ borderColor: UIColor, width: CGFloat) {
        
        let layerName: String = "bottom_layer"
        var bottomBorder: CALayer?
        
        for layer: CALayer in self.layer.sublayers!{
            if layer.name == layerName {
                bottomBorder = layer
                break
            }
        }
        
        if(bottomBorder == nil){
            bottomBorder = CALayer()
        }
        
        bottomBorder!.name = layerName
        bottomBorder!.frame = CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width)
        
        bottomBorder!.borderWidth = width
        bottomBorder!.borderColor = borderColor.cgColor
        
        self.layer.addSublayer(bottomBorder!)
        
    }
    
    func setLeftBorder(_ borderColor: UIColor, width: CGFloat) {
        
        let layerName: String = "left_layer"
        var leftBorder: CALayer?
        
        for layer: CALayer in self.layer.sublayers!{
            if layer.name == layerName {
                leftBorder = layer
                break
            }
        }
        
        if(leftBorder == nil){
            leftBorder = CALayer()
        }
        
        leftBorder!.name = layerName
        leftBorder!.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.height)
        
        leftBorder!.borderWidth = width
        leftBorder!.borderColor = borderColor.cgColor
        
        self.layer.addSublayer(leftBorder!)
    }
    
    func setRightBorder(_ borderColor: UIColor, width: CGFloat) {
        
        let layerName: String = "right_layer"
        var rightBorder: CALayer?
        
        for layer: CALayer in self.layer.sublayers!{
            if layer.name == layerName {
                rightBorder = layer
                break
            }
        }
        
        if(rightBorder == nil){
            rightBorder = CALayer()
        }
        
        rightBorder!.name = layerName
        rightBorder!.frame = CGRect(x: 0, y: self.frame.width, width: width, height: self.frame.height)
        
        rightBorder!.borderWidth = width
        rightBorder!.borderColor = borderColor.cgColor
        
        self.layer.addSublayer(rightBorder!)
    }
    
    func setCircleViewWith(_ borderColor: UIColor, width: CGFloat) {
        
        self.layer.cornerRadius = (self.frame.size.width / 2)
        self.layer.masksToBounds = (true)
        self.layer.borderWidth = (width)
        self.layer.borderColor = (borderColor.cgColor)
        
        let containerLayer: CALayer = CALayer()
        containerLayer.shadowColor = UIColor.black.cgColor
        
        containerLayer.shadowRadius = 10.0
        containerLayer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        containerLayer.shadowOpacity = 1.0
        self.superview?.layer.addSublayer(containerLayer)
        
    }
    
    func removeIndicatorFromView() {
        
        let layerNamebox: String = "bottom_box_layer"
        let layerNamepoint: String = "bottom_point_layer"
        
        for layer in self.layer.sublayers! {
            if layer.name == layerNamebox {
                layer.removeFromSuperlayer()
                break
            }
        }
        
        for layer in self.layer.sublayers! {
            if layer.name == layerNamepoint {
                layer.removeFromSuperlayer()
                break
            }
        }
        
    }
    
    func getViewControllerFromSubView() -> UIViewController? {
        
        var responder: UIResponder = self
        
        if responder.next != nil {
            responder = responder.next!
        }
        else {
            return nil
        }
        
        
        while !(responder.isKind(of: NSNull.self)) {
            if responder.isKind(of: UIViewController.self) {
                return responder as? UIViewController
            }
            responder = responder.next!
        }
        
        return nil
    }
    //  Get End X point of view
    var endX : CGFloat {
        return frame.origin.x + frame.width
    }
    
    //  Get End Y point of view
    var endY : CGFloat {
        return frame.origin.y + frame.height
    }
    
    //  Get Origin.x
    var startX : CGFloat {
        return frame.origin.x
    }
    
    //  Get Origin.y
    var startY : CGFloat {
        return frame.origin.y
    }
    
    //  Get width of View
    var getWidth : CGFloat {
        return frame.width
    }
    
    //  Get height of view
    var getHeight : CGFloat {
        return frame.height
    }
    
    //  Set Origin.x
    func setStartX(_ x : CGFloat) {
        self.frame.origin.x = x
    }
    
    //  Set Origin.y
    func setStartY( _ y : CGFloat) {
        self.frame.origin.y = y
    }
    
    //  Set view width
    func setWidth(_ width : CGFloat) {
        self.frame.size = CGSize(width: width, height: self.getHeight)
    }
    
    //  Set view height
    func setHeight( _ height : CGFloat) {
        self.frame.size = CGSize(width: self.getWidth, height: height)
    }
    
    //  Set Center
    func setCenter(_ x : CGFloat, y : CGFloat) {
        self.center = CGPoint(x : x,y: y)
    }
    
    //  Get center
    func getCenter() -> CGPoint {
        return self.center
    }
    
    // Set center.x
    func setCenterX(_ x: CGFloat) {
        self.center = CGPoint(x: x, y: self.getCenterY())
    }
    
    //  Get center.x
    func getCenterX() -> CGFloat {
        return self.center.x
    }
    
    //  Set center.y
    func setCenterY(_ y : CGFloat)  {
        self.center = CGPoint(x : self.getCenterX(), y : y)
    }
    
    //  Get center.y
    func getCenterY() -> CGFloat {
        return self.center.y
    }
    
    //  Get Parent View controller
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                return parentResponder as? UIViewController
            }
        }
        return nil
    }
    
    //  Apply plain shadow to view
    func applyPlainShadow() {
        let layer = self.layer
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 1.0
    }
    
    //  Apply boarder to view
    func applyBorder() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    //  Apply corner radius
    func applyCornerRadius(_ corenrRadius : CGFloat , mask : Bool) {
        self.layer.masksToBounds = mask
        self.layer.cornerRadius = corenrRadius
    }
    
    //  Add only bottom border
    func applyBottomBorder() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
    //  Add Top Border
    func addTopBorderWithColor(_ color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.getWidth, height: width)
        self.layer.addSublayer(border)
    }
    
    //  Add Right Border
    func addRightBorderWithColor(_ color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.getWidth - width, y: 0, width: width, height: self.getHeight)
        self.layer.addSublayer(border)
    }
    
    //  Add Bottom Border
    func addBottomBorderWithColor(_ color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.getHeight - width, width: self.getWidth, height: width)
        self.layer.addSublayer(border)
    }
    
    //  Add Left Border
    func addLeftBorderWithColor(_ color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.getHeight)
        self.layer.addSublayer(border)
    }
    
    
    // TODO: Autolayout Constraint
    func topEqualTo(view : UIView) -> Void{
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0))
    }
    
    func topSpaceToSuper(space : CGFloat) -> Void{
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.superview, attribute: .top, multiplier: 1.0, constant: space))
    }
    
    func topSpaceTo(view : UIView,space : CGFloat){
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: space))
    }
    
    func bottomEqualTo(view : UIView){
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0.0))
    }
    
    func bottomSpaceToSuper(spcae : CGFloat) -> Void{
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: self.superview, attribute: .bottom, multiplier: 1.0, constant: spcae))
    }
    
    func bottomSpaceTo(view : UIView,space : CGFloat){
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: space))
    }
    
    func leftMarginTo(view : UIView){
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0.0))
    }
    
    func leftMarginTo(view : UIView,margin : CGFloat){
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: margin))
    }
    
    func rightMarginTo(view : UIView){
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0.0))
    }
    
    func rightMarginTo(view : UIView,margin : CGFloat){
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: margin))
    }
    
    func horizontalSpace(view : UIView, space : CGFloat){
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: space))
    }
    
    func verticalSpace(view : UIView, space : CGFloat){
        self.superview?.addConstraint(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: space))
    }
    
    func edgeEqualTo(view : UIView){
        self.leftMarginTo(view: view)
        self.rightMarginTo(view: view)
        self.topEqualTo(view: view)
        self.bottomEqualTo(view: view)
    }
    
    func edgeToSuperView(top : CGFloat,left : CGFloat,bottom : CGFloat,right : CGFloat){
        self.topSpaceTo(view: self.superview!, space: top)
        self.bottomSpaceToSuper(spcae: bottom)
        self.leftMarginTo(view: self.superview!, margin: left)
        self.rightMarginTo(view: self.superview!, margin: right)
    }
    
    enum VerticalLocation: String {
        case bottom
        case top
    }
    func roundCornersView(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -10), color: color, opacity: opacity, radius: radius)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor = .gray, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
    /**
     Rounds the given set of corners to the specified radius
     
     - parameter corners: Corners to round
     - parameter radius:  Radius to round to
     */
    func round(corners: UIRectCorner, radius: CGFloat) {
        _ = _round(corners: corners, radius: radius)
    }
    
    /**
     Rounds the given set of corners to the specified radius with a border
     
     - parameter corners:     Corners to round
     - parameter radius:      Radius to round to
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = _round(corners: corners, radius: radius)
        addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
    }
    
    /**
     Fully rounds an autolayout view (e.g. one with no known frame) with the given diameter and border
     
     - parameter diameter:    The view's diameter
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func fullyRound(diameter: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = diameter / 2
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor;
    }
    
    @discardableResult func _round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }
    
    func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 1)
    }
    
    func setBorder(radius:CGFloat, color:UIColor = UIColor.clear) -> UIView{
        let roundView:UIView = self
        roundView.layer.cornerRadius = CGFloat(radius)
        roundView.layer.borderWidth = 2
        roundView.layer.borderColor = color.cgColor
        roundView.clipsToBounds = true
        return roundView
    }
    
}
