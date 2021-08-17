var counter = 0
private func printOperation(_ name: String, _ option: Option) {
    let suffix: String = {
        if option == .a { return "a" }
        if option == .b { return "b" }
        return String(Array(name)[0])
    }()
    counter += 1
    if !muted { print(name + suffix + "\t[\(counter)]") }
    if counter > limit { quit("counter exceeded limit") }
    if debug { describe(a, b) }
}

enum Option {
    case a
    case b
    case both
}

func s(_ option: Option) {
    guard let _ =  option == .a ? a?.down : b?.down else { return }
    if option == .a || option == .both { a?.swap() }
    if option == .b || option == .both { b?.swap() }
    printOperation("s", option);
}

func p(_ option: Option) {
    guard let _ =  option == .a ? b : a else { return }
    if option == .a || option == .both { push(&b, on: &a) }
    if option == .b || option == .both { push(&a, on: &b) }
    printOperation("p", option);
}

func r(_ option: Option) {
    guard let _ =  option == .a ? a?.down : b?.down else { return }
    if option == .a || option == .both { rotate(&a) }
    if option == .b || option == .both { rotate(&b) }
    printOperation("r", option);
}

func rr(_ option: Option) {
    guard let _ =  option == .a ? a?.down : b?.down else { return }
    if option == .a || option == .both { rrotate(&a) }
    if option == .b || option == .both { rrotate(&b) }
    printOperation("rr", option);
}
