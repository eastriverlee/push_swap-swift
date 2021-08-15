import Darwin

func quit() {
    print("Error")
    if debug { describe(a, b) }
    exit(0)
}

func fill() -> [Int] {
    var arguments = CommandLine.arguments
    arguments = Array(arguments[1 ..< arguments.count])
    if arguments.count == 1 {
        arguments = arguments[0].components(separatedBy: " ")
    }
    return arguments.map{Int($0)!}
}

var numbers = fill()
if Set(numbers).count != numbers.count {
    print("Error: repeating numbers")
    print("Generating new set......")
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
var a = buildStack(from: numbers)
var b = buildStack(from: [])

let sortedNumbers = numbers.sorted()

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

func sort() {
    let count = numbers.count
    for i in 0 ..< count {
        get(sortedNumbers[i], from: .a)
        p(.b)
    }
    for _ in 0 ..< count {
        p(.a)
    }
}

let debug = false
if let a = a, !a.isSorted(by: .ascending) {
    sort()
}
describe(a, b)
