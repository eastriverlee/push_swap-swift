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
    let this = option
    let other: Option = (this == .a ? .b : .a)
    var stack: Stack { option == .a ? a! : b! }
    var otherStack: Stack { option == .a ? b! : a! }
    let fromTop = numbers.areCloserFromTop(of: stack)
    var leftover: Int!

    func pushOne() {
        leftover = stack.number == numbers[0] ? numbers[1] : numbers[0]
        p(other)
        if !otherStack.isSorted(to: 1, by: .descending) { s(other) }
    }
    while numbers[0] != stack.number && numbers[1] != stack.number {
        fromTop ? r(this) : rr(this)
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

func roughSort() {
    let aThird = numbers.count / 3
    let pivot = [sortedNumbers[aThird], sortedNumbers[aThird * 2]]
    var small: Bool { a!.number < pivot[0] }
    var great: Bool { a!.number >= pivot[0] }
    var greater: Bool { a!.number >= pivot[1] }
    for _ in 0 ..< a!.count {
        if small || (great && !greater) { p(.b) }
        else { r(greater ? .both : .a) }
    }
    for _ in 0 ..< a!.count {
        p(.b)
    }
}

func sort(from target: Option) {
    let this = target
    let other: Option = (this == .a ? .b : .a)
    let count = (this == .a ? a : b)?.count ?? 0
    var first: Int  { this == .a ? sortedNumbers[i] : sortedNumbers[i] }
    var second: Int { this == .a ? sortedNumbers[i+1] : sortedNumbers[i-1] }
    var i = this == .a ? 0 : count-1
    let chunk = 2
    while i <= count-chunk {
        get(two: [first, second], from: this)
        i += this == .a ? chunk : -chunk
    }
    if let stack = (this == .a ? a : b) {
        for _ in 0 ..< stack.count {
            get(sortedNumbers[i], from: this)
            p(other)
            i += this == .a ? 1 : -1
        }
    }
    if let stack = b, this == .a {
        for _ in 0 ..< stack.count { p(this) }
    }
}

let limit = 30000
let debug = false
let numbers = fill()
let sortedNumbers = numbers.sorted()

var a = buildStack(from: numbers)
var b = buildStack(from: [])

func main() {
    if let a = a, !a.isSorted(by: .ascending) {
        roughSort()
        sort(from: .b)
    }
    describe(a, b)
}

main()
