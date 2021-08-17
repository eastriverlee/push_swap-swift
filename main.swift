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
    if Set(numbers).count != count {
        print("Error: repeating numbers".red)
        print("Generating new set......\n".green)
        let desiredCount = count
        numbers = Array(Set(numbers))
        var count = count
        while count < desiredCount {
            let n = Int(Int32.random(in: Int32.min...Int32.max))
            if !numbers.contains(n) {
                numbers.append(n)
                count += 1
            }
        }
    }
    return numbers
}

func push(_ number: Int, from this: Option) {
    var stack: Stack { this == .a ? a! : b! }
    let other: Option = (this == .a ? .b : .a)

    if number.isCloserFromTop(of: stack) {
        while number != stack.number {
            r(this)
        }
    } else {
        while number != stack.number {
            rr(this)
        }
    }
    p(other)
}

func push(three numbers: [Int], from this: Option) {
    let other: Option = (this == .a ? .b : .a)
    var stack: Stack { this == .a ? a! : b! }
    var otherStack: Stack? { this == .a ? b : a }
    let fromTop = numbers.areCloserFromTop(of: stack)
    var leftover: Int!

    func pushOne() {
        p(other)
        if !(otherStack?.isSorted(to: 1, by: other == .b ? .descending : .ascending) ?? true) {
            s(other)
        }
    }
    func get(_ i: Int, or j: Int) {
        while i != stack.number && j != stack.number {
            fromTop ? r(this) : rr(this)
        }
        leftover = stack.number == i ? j : i
    }
    get(numbers[0], or: numbers[1])
    pushOne()
    get(leftover, or: numbers[2])
    pushOne()
    push(leftover, from: this)
}

extension Sequence where Iterator.Element == Int {
    func areCloserFromTop(of stack: Stack) -> Bool {
        let count = stack.count
        let middle = count / 2
        let distance: [Int] = self.map { stack.find($0) }
        return distance.reduce(0, +)/distance.count < middle
    }
}

func sortThree(of this: Option) {
    var stack: Stack { this == .a ? a! : b! }
    let array = stack[0..<stack.count]
    if stack.number == array.max()! {
        r(this)
    }
    if !stack.isSorted(to: 2, by: this == .a ? .ascending : .descending) {
        s(this)
    }
}

let limit = 30000
let debug = false
let numbers = fill()
let count = numbers.count
let sortedNumbers = numbers.sorted()

func sort(only count: Int = count, from index: inout Int, end: Bool = false) {
    let range = 0..<count
    let smallest = sortedNumbers[index - (count-1)]
    let biggest = sortedNumbers[index]
    var bCount = 0

    while bCount < count {
        if smallest <= a!.number && a!.number <= biggest {
            p(.b)
            bCount += 1
        } else { r(.a) }
    }
    for _ in range { push(sortedNumbers[index--], from: .b) }
    if !end { for _ in range { r(.a) } }
}

var a = buildStack(from: numbers)
var b = buildStack(from: [])

func main() {
    var index = count-1
    let firstHalf = count/2
    let secondHalf = count-firstHalf
    guard let A = a else { quit(true); return }

    if !A.isSorted(by: .ascending) {
      sort(only: firstHalf, from: &index)
      sort(only: secondHalf, from: &index, end: true)
    }
    describe(a, b, color: (a?.isSorted(by: .ascending) ?? false) ? .green : .red)
}

main()
