private func printOperation(_ name: String, _ option: Option) {
    let suffix = (option != .both ? option.rawValue : name.first!)
    counter += 1
    if !muted { print(name + "\(suffix)\t[\(counter)]") }
    if counter > limit { quit("counter exceeded limit") }
    if debug { describe(A, B) }
}

enum Option: Character {
    case a = "a"
    case b = "b"
    case both = "x"
    var isA: Bool { self == .a || self == .both }
    var isB: Bool { self == .b || self == .both }
    var order: Order { isA ? .ascending : .descending }
    var counter: Option { self == .a ? .b : .a }
    var stack: Stack? { self == .a ? A : B }
}

func s(_ option: Option) {
    guard let stack = option.stack else { return }
    guard let down = stack.down else { return }
    debugPrint("swapping \(stack.number) with \(down.number)")
    if option.isA { A?.swap() }
    if option.isB { B?.swap() }
    printOperation("s", option);
}

func p(_ option: Option) {
    guard let stack = option.counter.stack else { return }
    debugPrint("pushing \(stack.number) onto \(option.rawValue)")
    if option.isA { push(&B, on: &A) }
    if option.isB { push(&A, on: &B) }
    printOperation("p", option);
}

func r(_ option: Option) {
    guard let stack = option.stack else { return }
    guard let _ =  stack.down else { return }
    debugPrint("rotating \(stack.number) to bottom")
    if option.isA { rotate(&A) }
    if option.isB { rotate(&B) }
    printOperation("r", option);
}

func rr(_ option: Option) {
    guard let stack = option.stack else { return }
    guard let _ =  stack.down else { return }
    debugPrint("rotating \(stack.bottom.number) to top")
    if option.isA { rrotate(&A) }
    if option.isB { rrotate(&B) }
    printOperation("rr", option);
}
