import UIKit
import JavaScriptCore

class IntegrationJS {

    lazy var context: JSContext? = {
        let context = JSContext()
        guard let scriptJSPath = Bundle.main.path(forResource: "script", ofType: "js") else {
            print("Unable to read resource files.")
            return nil
        }
        do {
            let script = try String(contentsOfFile: scriptJSPath, encoding: String.Encoding.utf8)
            _ = context?.evaluateScript(script)
        } catch (let error) {
            print("Error while processing script file: \(error)")
        }
        return context
    }()

    init() {
        printValues()
        callWithArguments(value: 5, value2: 10)
        callWithArguments(value: 50, value2: 10)
    }

    func printValues() {
        guard let context = context else {
            print("JSContext not found.")
            return
        }
        guard let integerValue = context.objectForKeyedSubscript("integerValue"),
            let floatValue = context.objectForKeyedSubscript("floatValue"),
            let stringValue = context.objectForKeyedSubscript("stringValue") else {
                print("value for key value not found")
                return
        }
        print("integerValue: \(integerValue)")
        print("floatValue: \(floatValue)")
        print("stringValue: \(stringValue)")
    }

    func callWithArguments(value: Int, value2: Int) {
        guard let context = context else {
            print("JSContext not found.")
            return
        }

        let sumValues = context.objectForKeyedSubscript("sumValues")
        guard let sum = sumValues?.call(withArguments: [value, value2])?.toInt32() else {
            print("sum error")
                return
        }
        print("sum: \(sum)")
    }
}

_ = IntegrationJS()
