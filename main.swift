import Darwin

func quit(_ description: String = "") {
    if !description.isEmpty || debug { describe(a, b) }
    print("ERROR".red)
    print(description.yellow)
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
    let desiredCount = numbers.count
    numbers = Array(Set(numbers))
    if Set(numbers).count != desiredCount {
        print("Error: repeating numbers".red)
        print("Generating new set......\n".green)
        var count = numbers.count
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

func push(_ number: Int, from here: Option) {
    var stack: Stack { here == .a ? a! : b! }
    let there: Option = (here == .a ? .b : .a)

    if number.isCloserFromTop(of: stack) {
        while number != stack.number {
            r(here)
        }
    } else {
        while number != stack.number {
            rr(here)
        }
    }
    p(there)
}
func push(_ i: Int, and j: Int, from here: Option) {
    var stack: Stack { here == .a ? a! : b! }
    var other: Stack { here == .a ? b! : a! }
    let there: Option = (here == .a ? .b : .a)

    let distance = [stack.find(i), stack.find(j)].map { $0 > count/2 ? count-$0 : $0 }
    let correctOrder = distance[0] > distance[1]
    push(correctOrder ? i : j, from: here)
    push(correctOrder ? j : i, from: here)
    if !other.isSorted(to: 1, by: there == .a ? .ascending : .descending) { s(there) }
}

extension Sequence where Iterator.Element == Int {
    func areCloserFromTop(of stack: Stack) -> Bool {
        let count = stack.count
        let middle = count / 2
        let distance: [Int] = self.map { stack.find($0) }
        return distance.reduce(0, +)/distance.count < middle
    }
}

func sortThree(of here: Option) {
    var stack: Stack { here == .a ? a! : b! }
    let array = stack[0..<min(3, stack.count)]
    let extreme = here == .a ? array.max()! : array.min()!
    if let second = stack.down, second.number == extreme {
        rr(here)
    }
    if stack.number == extreme { 
        r(here)
    }
    if !stack.isSorted(to: 2, by: here == .a ? .ascending : .descending) {
        s(here)
    }
}

func sortFive(of here: Option) {
    var stack: Stack { here == .a ? a! : b! }
    let array = stack[0..<min(5, stack.count)]
    let sortedFive = array.sorted()
    let first = sortedFive[here == .a ? 0 : array.count-1]
    let second = sortedFive[here == .a ? 1 : array.count-2]

    if array.count > 3 { push(first, and: second, from: here) }
    sortThree(of: here)
    p(.a)
    p(.a)
}

func sort(only count: Int = count, from index: inout Int, end: Bool = false) {
    let small = sortedNumbers[index - (count-1)]
    let big = sortedNumbers[index]
    var bCount = 0

    while bCount < count {
        if small <= a!.number && a!.number <= big {
            p(.b)
            bCount += 1
        } else { r(.a) }
    }
    var i = 0
    while bCount > 5 { 
        push(sortedNumbers[index], and: sortedNumbers[index-1], from: .b)
        index -= 2
        bCount -= 2
    }
    index -= bCount
    sortFive(of: .b)
    while b != nil { p(.a) }
    if !end { for _ in 0..<count { r(.a) } }
}

func sortDivide(by parts: Int) {
    var index = count-1
    let part = count/parts
    let leftover = part + count%parts

    for _ in 0..<parts-1 {
        sort(only: part, from: &index)
    }
    sort(only: leftover, from: &index, end: true)
}

func reset() {
    a = nil
    b = nil
    a = buildStack(from: numbers)
    counter = 0
}

func findBestDivision(from skip: Int = 0) -> Int {
    var performance: [Int] = []

    muted = true
    for i in 1...10 {
        if skip < i {
            reset()
            sortDivide(by: i)
            print("instrunctions count: \(counter)".yellow)
            performance.append(counter)
        }
    }
    let min = performance.min()!
    let best = skip+performance.firstIndex{ $0 == min }!+1
    print("performance: \(performance)")
    print("best performance: \(min)")
    print("best division: \(best)")
    reset()
    muted = false
    return best
}


//MARK: - main

let limit = 40000
let debug = false
var muted = false
let numbers = fill()
let count = numbers.count

let sortedNumbers = numbers.sorted()

var a = buildStack(from: numbers)
var b = buildStack(from: [])

func main() {
    switch count {
         case 1...3: sortThree(of: .a)
         case 4...5: sortFive(of: .a)
         case 6..<100: sortDivide(by: 2)
         case 100..<500: sortDivide(by: 4)
         default: sortDivide(by: findBestDivision())
    }
    //describe(a, b)
    print((a?.isSorted(by: .ascending) ?? false) ? "OK".green : "KO".red)
    print("instrunctions count: \(counter)".yellow)
}

main()
