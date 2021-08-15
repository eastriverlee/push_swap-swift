import Darwin

func quit(_ force: Bool = false) {
    print("Error")
    if force || debug { describe(a, b) }
    exit(0)
}

func fill() -> [Int] {
    var numbers: [Int] = []
    var arguments = CommandLine.arguments
    arguments = Array(arguments[1 ..< arguments.count])
    if arguments.count == 1 {
        arguments = arguments[0].components(separatedBy: " ")
    }
    numbers = arguments.map{Int($0)!}
    if Set(numbers).count != numbers.count {
        print("Error: repeating numbers".red)
        print("Generating new set......\n".green)
        let desiredCount = numbers.count
        numbers = Array(Set(numbers))
        var count = numbers.count
        while count < desiredCount {
            let n = Int(Int32.random(in: Int32.min ... Int32.max))
            if !numbers.contains(n) {
                numbers.append(n)
                count += 1
            }
        }
    }
    return numbers
}

func get(_ number: Int, from option: Option) {
    var stack: Stack { option == .a ? a! : b! }

    if number.isCloserFromTop(of: stack) {
        while number != stack.number {
            r(option)
        }
    } else {
        while number != stack.number {
            rr(option)
        }
    }
}

func get(two numbers: [Int], from option: Option) {
    var stack: Stack { option == .a ? a! : b! }
    let fromTop = numbers.areCloserFromTop(of: stack)
    var leftover: Int!

    func pushOne() {
        leftover = a!.number == numbers[0] ? numbers[1] : numbers[0]
        p(.b)
        if !b!.isSorted(to: 1, by: .descending) {
            s(.b)
        }
    }
    while numbers[0] != stack.number && numbers[1] != stack.number {
        fromTop ? r(.a) : rr(.a)
    }
    pushOne()
    get(leftover, from: option)
    pushOne()
}

extension Sequence where Iterator.Element == Int {
    func areCloserFromTop(of stack: Stack) -> Bool {
        let count = stack.count
        let middle = count / 2
        let distance: [Int] = self.map { stack.find($0) }
        return distance.reduce(0, +)/distance.count < middle
    }
}

func sort() {
    let count = numbers.count
    var i = 0
    while i <= count-2 {
        get(two: [sortedNumbers[i], sortedNumbers[i+1]], from: .a)
        i += 2
    }
    if let a = a {
        for _ in 0 ..< a.count {
            get(sortedNumbers[i], from: .a)
            p(.b)
        }
    }
    if let b = b {
        for _ in 0 ..< b.count { p(.a) }
    }
}

let debug = false
let numbers = fill()
let sortedNumbers = numbers.sorted()
var a = buildStack(from: numbers)
var b = buildStack(from: [])

func main() {
    if let a = a, !a.isSorted(by: .ascending) {
        sort()
    }
    describe(a, b)
}

main()
