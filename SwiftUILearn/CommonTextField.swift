import SwiftUI

/// 汎用的な入力欄(iOS16.0~)
/// フォーカスアウト時の入力チェックを呼び出し元で差し替える
/// 入力欄の種類
/// ・パスワード
/// ・ユーザーネーム
/// ・電話番号(半角数字)
/// ・メールアドレス

struct CommonTextField: View {
    
    @State private var text: String = ""
    @State private var isValid: Bool = false
    /// 入力最大文字数
    var maximumLength: Int = 8
    /// 入力最小文字数
    var minimumLength: Int = 4
    
    var body: some View {
        TextField(
            text: $text,
            axis: .vertical
        ) {
            
        }
        .textFieldStyle(
            .roundedBorder
        )
        .onChange(of: text) { newValue in
            filterInvalidCharacters(text: newValue)
            validationInput()
        }
    }
    @discardableResult
    func validationInput() -> Bool {
        // 半角英数字のみを許可する正規表現
        let allowedCharacters = "^[a-zA-Z0-9]*$"
        // 空文字の場合
        if text.isEmpty {
            isValid = false
            print("空文字")
        }
        // 半角英数字以外を入力した場合
        if text.range(of: allowedCharacters,options: .regularExpression) == nil {
            isValid = false
            print("半角英数字以外")
        }
        // 最小または最大入力文字数に満たない場合
        if text.count < minimumLength || text.count > maximumLength {
            isValid = false
            print("入力文字数に満たない")
        }
        isValid = true
        return isValid
    }
    // 指定外の文字を取り除く処理
    private func filterInvalidCharacters(text: String) {
        // 半角英数字のみを許可する正規表現
        let allowedCharacters = "^[a-zA-Z0-9]*$"
        let filteredText = text.filter { char in
            String(char).range(of: allowedCharacters, options: .regularExpression) != nil
        }
        // フィルタリングされた文字列をtextに再セット
        self.text = filteredText
        print("許可された入力値",self.text)
    }
}

#Preview {
    CommonTextField()
        .padding()
}
