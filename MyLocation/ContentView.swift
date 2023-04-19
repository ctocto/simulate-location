//
//  ContentView.swift
//  MyLocation
//
//  Created by ctocto on 2023/4/17.
//

import SwiftUI

struct LabelledDivider: View {

    let label: String
    let horizontalPadding: CGFloat
    let color: Color

    init(label: String, horizontalPadding: CGFloat = 5, color: Color = .gray) {
        self.label = label
        self.horizontalPadding = horizontalPadding
        self.color = color
    }

    var body: some View {
        HStack {
            line
            Text(label).foregroundColor(color)
            line
        }
    }

    var line: some View {
        VStack { Divider().background(color) }.padding(horizontalPadding)
    }
}

struct ContentView: View {
    @EnvironmentObject var viewModal: LocationManager
    
    var body: some View {
        VStack {
            Text("My Location").font(.title).bold()
            Spacer()
            Group {
                Text("目标").bold()
                HStack {
                    Text("经度：").font(.subheadline)
                    Spacer()
                    Text("120.22287161120487").font(.subheadline)
                }
                HStack {
                    Text("纬度：").font(.subheadline)
                    Spacer()
                    Text("30.21307853153179").font(.subheadline)
                }
            }
            Divider().background(.white).padding([.vertical], 20)
            Group {
                Text("获取").bold()
                HStack(
                    alignment: .top
                ) {
                    Text("时间：").font(.subheadline)
                    Spacer()
                    if let location = viewModal.location {
                        Text("\(location.timestamp)").font(.subheadline)
                    } else {
                        Text("Unknown")
                    }
                }
                Divider()
                HStack {
                    Text("经度：").font(.subheadline)
                    Spacer()
                    if let location = viewModal.location {
                        Text("\(location.coordinate.longitude)").font(.subheadline)
                    } else {
                        Text("Unknown")
                    }
                }
                HStack {
                    Text("纬度：").font(.subheadline)
                    Spacer()
                    if let location = viewModal.location {
                        Text("\(location.coordinate.latitude)").font(.subheadline)
                    } else {
                        Text("Unknown")
                    }
                }
            }
            LabelledDivider(label: "check", horizontalPadding: 0)
            Group {
                HStack {
                    Text("海拔：").font(.subheadline)
                    Spacer()
                    if let location = viewModal.location {
                        Text("\(location.altitude)").font(.subheadline)
                    } else {
                        Text("Unknown")
                    }
                }
                HStack {
                    Text("水平精度：").font(.subheadline)
                    Spacer()
                    if let location = viewModal.location {
                        Text("\(location.horizontalAccuracy)").font(.subheadline)
                    } else {
                        Text("Unknown")
                    }
                }
                HStack {
                    Text("垂直精度：").font(.subheadline)
                    Spacer()
                    if let location = viewModal.location {
                        Text("\(location.verticalAccuracy)").font(.subheadline)
                    } else {
                        Text("Unknown")
                    }
                }
            }
            LabelledDivider(label: "other")
            Group {
                HStack {
                    Text("方向：").font(.subheadline)
                    Spacer()
                    if let location = viewModal.location {
                        Text("\(location.course)").font(.subheadline)
                    } else {
                        Text("Unknown")
                    }
                }
                HStack {
                    Text("速度：").font(.subheadline)
                    Spacer()
                    if let location = viewModal.location {
                        Text("\(location.speed)").font(.subheadline)
                    } else {
                        Text("Unknown")
                    }
                }
            }
            Button("Refresh") {
                print("---------refresh--------")
                viewModal.requestLocation()
            }.buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(LocationManager())
    }
}
