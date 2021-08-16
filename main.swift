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
            let n = Int(Int32.random(in: Int32.min ... Int32.max))
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
            print("finding \(number) ", terminator: "")
            r(this)
        }
    } else {
        while number != stack.number {
            print("finding \(number) ", terminator: "")
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

func roughSort() {
    let aThird = count / 3
    let twoThird = aThird * 2
    let pivot = [sortedNumbers[aThird-1], sortedNumbers[twoThird-1]]
    var bCount = 0
    func small(_ n: Int) -> Bool { n < pivot[0] }
    func great(_ n: Int) -> Bool { n >= pivot[0] }
    func greater(_ n: Int) -> Bool { n >= pivot[1] }

    while bCount < twoThird {
        if great(a!.number) {
            p(.b); bCount += 1
            if greater(b!.number) {
                r(a != nil && small(a!.number) ? .both : .b)
            }
        } else { r(.a) }
    }
    var i = count - 1
    for _ in 0 ..< twoThird {
        push(sortedNumbers[i--], from: .b)
    }
    //for _ in 0 ..< count-bCount {
    //    p(.b)
    //}
}

//func sort(from this: Option) {
//    let other: Option = this == .a ? .b : .a
//    let count = (this == .a ? a : b)?.count ?? 0
//    var first: Int  { this == .a ? sortedNumbers[i] : sortedNumbers[i] }
//    var second: Int { this == .a ? sortedNumbers[i+1] : sortedNumbers[i-1] }
//    var third: Int { this == .a ? sortedNumbers[i+2] : sortedNumbers[i-2] }
//    var i = this == .a ? 0 : count - 1
//    let chunk = 3
//    while i <= count-chunk {
//        push(three: [first, second, third], from: this)
//        i += this == .a ? chunk : -chunk
//    }
//    if let stack = (this == .a ? a : b) {
//        for _ in 0 ..< stack.count {
//            push(sortedNumbers[i], from: this)
//            i += this == .a ? 1 : -1
//        }
//    }
//    if let stack = b, this == .a {
//        for _ in 0 ..< stack.count { p(.a) }
//    }
//}

func sortInsert() {
    if a == nil || b!.number < a!.number {
        p(.a)
        return
    }
    p(.b)
    r(.b)
    sortInsert()
    rr(.b)
    p(.a)
}

func sort() {
    if a != nil {
        p(.b)
        sort()
        sortInsert()
    }
}

let limit = 30000
let debug = false
let numbers = fill()
let count = numbers.count
let sortedNumbers = numbers.sorted()

var a = buildStack(from: numbers)
var b = buildStack(from: [])

func main() {
    if let a = a, !a.isSorted(by: .ascending) {
        //roughSort()
        //sort(from: .a)
        sort()
    }
    describe(a, b, color: (a?.isSorted(by: .ascending) ?? false ? .green : .red))
}

main()
