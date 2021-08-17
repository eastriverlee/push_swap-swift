import Foundation

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

func push(_ number: Int, from here: Option) {
    var stack: Stack { here == .a ? a! : b! }
    let there: Option = (here == .a ? .b : .a)
    let isCloserFromTop = number.isCloserFromTop(of: stack)

    while number != stack.number {
        isCloserFromTop ? r(here) : rr(here)
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
            p(.b); bCount += 1
        } else { r(.a) }
    }
    while bCount > 5 { 
        push(sortedNumbers[index], and: sortedNumbers[index-1], from: .b); bCount -= 2; index -= 2
    }
    sortFive(of: .b); index -= bCount
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
