import Foundation

postfix operator ++
postfix operator --

extension Int {
    func isCloserFromTop(of stack: Stack) -> Bool {
        let middle = stack.count / 2
        var current = stack
        for _ in 0 ..< middle {
            if self == current.number { return true }
            current = current.down!
        }
        return false
    }
}

postfix func ++(x: inout Int) -> Int {
    x += 1
    return x - 1
}

postfix func --(x: inout Int) -> Int {
    x -= 1
    return x + 1
}

enum ANSI: String {
    case black = "\u{001B}[0;30m"
    case red = "\u{001B}[0;31m"
    case green = "\u{001B}[0;32m"
    case yellow = "\u{001B}[0;33m"
    case blue = "\u{001B}[0;34m"
    case magenta = "\u{001B}[0;35m"
    case cyan = "\u{001B}[0;36m"
    case white = "\u{001B}[0;37m"
    case none = "\u{001B}[0;0m"
}

extension String {
    var black: String { ANSI.black.rawValue + self + ANSI.none.rawValue }
    var red: String { ANSI.red.rawValue + self + ANSI.none.rawValue }
    var green: String { ANSI.green.rawValue + self + ANSI.none.rawValue }
    var yellow: String { ANSI.yellow.rawValue + self + ANSI.none.rawValue }
    var blue: String { ANSI.blue.rawValue + self + ANSI.none.rawValue }
    var magenta: String { ANSI.magenta.rawValue + self + ANSI.none.rawValue }
    var cyan: String { ANSI.cyan.rawValue + self + ANSI.none.rawValue }
    var white: String { ANSI.white.rawValue + self + ANSI.none.rawValue }
    var none: String { ANSI.none.rawValue + self + ANSI.none.rawValue }
}

func debugPrint(_ description: String) {
    if debug {
        print(description.yellow)
    }
}
