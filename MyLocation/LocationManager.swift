//
//  LocationManager.swift
//  MyLocation
//
//  Created by ctocto on 2023/4/18.
//

import Foundation
import UIKit
import CoreLocation


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    // create a property to store the location
    @Published var location: CLLocation? = nil
    //定位管理器
    let locationManager:CLLocationManager = CLLocationManager()
    
    
    override init() {
        super.init()
        
        //设置定位服务管理器代理
        locationManager.delegate = self
        //设置定位进度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //更新距离
        locationManager.distanceFilter = 1
        // 发送授权申请
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        // 进入后台后停止
        locationManager.pausesLocationUpdatesAutomatically = true
    }
    
    // 开始尝试获取定位
    public func startRequestLocation() {
        if self.locationManager.authorizationStatus == .denied {
            // 没有获取到权限，再次请求授权
            print("拒绝授权")
            self.locationManager.requestWhenInUseAuthorization()
        } else {
            print("开始定位")
            locationManager.startUpdatingLocation()
        }
    }
    //定位改变执行，可以得到新位置、旧位置
    public  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //获取最新的坐标
        print("获取定位结果")
        let currLocation:CLLocation = locations.last!
        print("获取定位结果")
        // https://developer.apple.com/documentation/corelocation/cllocation#4063398
        print("经度：\(currLocation.coordinate.longitude)\n纬度：\(currLocation.coordinate.latitude)\n海拔：\(currLocation.altitude)\n水平精度：\(currLocation.horizontalAccuracy)\n垂直精度：\(currLocation.verticalAccuracy)\n方向：\(currLocation.course)\n速度：\(currLocation.speed)")
        self.location = currLocation
    }
    // 代理方法，当定位授权更新时回调
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("授权变化")
        // CLAuthorizationStatus
        // .notDetermined   用户还没有选择授权
        // .restricted   应用没有授权用户定位
        // .denied 用户禁止定位
        // .authorizedAlways 用户授权一直可以获取定位
        // .authorizedWhenInUse 用户授权使用期间获取定位
        // TODO...
        if status == .notDetermined {
            // 未授予
            print("未授予")
        } else if (status == .restricted) {
            // 受限制，尝试提示然后进入设置页面进行处理
            print("受限制，尝试提示然后进入设置页面进行处理")
        } else if (status == .denied) {
            // 被拒绝，尝试提示然后进入设置页面进行处理
            print("被拒绝，尝试提示然后进入设置页面进行处理")
        }else{
            startRequestLocation()
        }
    }
    
    // 当获取定位出错时调用
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // 这里应该停止调用api
        print(error)
        print(error.localizedDescription)
        print("定位失败")
        self.locationManager.stopUpdatingLocation()
    }
    
    public func requestLocation() {
        self.locationManager.requestLocation()
    }
}
