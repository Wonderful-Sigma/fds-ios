import SwiftUI

@available(macOS 12, iOS 15, *)
public struct QRCodeView: View {
    
    @State var time: Int?
    @State var data: String?
    @State var isError: Bool = false
    
    let coin: Int
    let action: () async throws -> String
    
    public init(coin: Int,
                action: @escaping () async throws -> String) {
        self.coin = coin
        self.action = action
    }
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if let time {
                if time == 0 {
                    data = nil
                    self.time = nil
                } else {
                    self.time = time - 1
                }
            }
        }
    }
    
    func executeAction() async {
        isError = false
        do {
            data = try await action()
            time = 30
        } catch {
            self.isError = true
        }
    }
    
    public var body: some View {
        VStack(spacing: 50) {
            VStack(spacing: 12) {
                Text("QR 결제")
                    .foregroundStyle(Color.lightBlack)
                    .font(.system(size: 20, weight: .semibold))
                HStack(spacing: 8) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.blue400)
                    Text("\(coin.formatted())코인")
                        .font(.system(size: 17, weight: .medium))
                }
            }
            VStack(spacing: 20) {
                ZStack {
                    Image(FlickImage.qrOuterShape)
                        .resizable()
                    if let data {
                        QRShape(data)
                            .padding(12.5)
                    } else {
                        Text(isError
                             ? "오류가 발생했습니다"
                             : "QR코드를 다시 생성해주세요")
                        .font(.system(size: 13, weight: .medium))
                    }
                }
                .frame(width: 280, height: 280)
                Group {
                    if let time {
                        Text("QR코드 사용 종료까지 ")
                            .foregroundColor(Color.lightGray)
                        +
                        Text("\(time)초")
                        +
                        Text(" 남았어요")
                            .foregroundColor(Color.lightGray)
                    } else {
                        Color.clear
                    }
                }
                .frame(height: 19)
                .font(.system(size: 16))
                Button {
                    Task {
                        await executeAction()
                    }
                } label: {
                    HStack {
                        Text("다시 생성하기")
                            .font(.system(size: 13))
                        Image(FlickImage.reloadIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
        .foregroundStyle(Color.subTitle)
        .padding(.bottom, 35)
        .task {
            await executeAction()
            _ = timer
        }
    }
}
