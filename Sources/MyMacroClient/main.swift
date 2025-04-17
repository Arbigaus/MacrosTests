import MyMacro
import Combine

let a = 17
let b = 25

//let (result, code) = #stringify(a + b)
//
//print("The value \(result) was produced by the code \"\(code)\"")

class TestMacro: ObservableObject {
    @Published var text: String = ""

    func updateString() {
        text = "Some text update"
    }
}
var cancellables: Set<AnyCancellable> = []

let testMacro = TestMacro()

