# Swift API Design Guidelines

iOS Developer 오픈 카톡을 보다가 어떤 한 분이 [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines) 내용을 잘 정리해주신 강의를 만들었다고 올려주셔서 구매해서 듣게되었는데...

나는 지금까지 기계처럼 일하고 공부하기만 했구나라는 생각이 들게되었던 하루다... 

앞으로는 최신 기술 / 지식만 쌓는게 아니라 어떻게 해야 더 좋은 코드가 될지 고민하고 또 고민하는 개발자가 되어야겠다고 생각하며 공부했던 내용을 정리해보겠습니다...

## 🛠 Fundamentals
우선 Swift API Design Guidelines 에 있는 내용을 토대로 정리해보겠습니다...
---

> - **Clarity at the point of use** is your most important goal. Entities such as methods and properties are declared only once but *used* repeatedly. Design APIs to make those uses clear and concise. When evaluating a design, reading a declaration is seldom sufficient; always examine a use case to make sure it looks clear in context.
> - **Clarity is more important than brevity.** Although Swift code can be compact, it is a *non-goal* to enable the smallest possible code with the fewest characters. Brevity in Swift code, where it occurs, is a side-effect of the strong type system and features that naturally reduce boilerplate.
> - **Write a documentation comment** for every declaration. Insights gained by writing documentation can have a profound impact on your design, so don’t put it off.

라고 되어있습니다.

차근차근 해석을 한번 해봅시다. 해석을 하면서 정리를 하고 정리를 하면서 머리 속에 각인 시켜봅니다.

> 1. **사용하는 쪽에서의 명확성이 가장 중요하다.** 메소드나 프로퍼티같은 요소들은 한번 선언되지만 반복적으로 사용됩니다. 그런 요소들을명확하고 간결하게 사용할 수 있도록 API를 설계하라. 설계를 평가할 때, 선언을 보고 평가하는 경우는 거의 없다. 항상 유스 케이스를 바탕으로 평가를 합니다. 특정 문맥에서 명확하게 보이는지 확인하십시오.
> 2. **명확한 것이 간결한 것보다 중요하다.** Swift 코드는 간단하게 편할 수 있지만, 적은 코드가 목표가 아니다. Swift 코드에서 간결함은 강력한 Type System과 boilerplate(최소한의 변경으로 여러곳에서 재사용되며, 반복적으로 비슷한 형태를 띄는 코드를 말한다.) 를 줄여주는 기능 덕분이다.(결국 짧게 표현하는 것을 목표로 두지 말자라는 의미입니다.)
> 3. **모든 선언에 주석을 작성하라.** 주석을 작성하면서 얻은 이해는 당신의 설계에 큰 영향을 줄 수 있다.
>    (근데 저의 생각은 실무에서는 모든 선언에 주석을 다는 것은 어려운 일이라 생각하여 자주 사용하는 함수 / 유틸로 사용하는 함수 혹은 외부에 공개되는 함수들에는 주석을 작성하는 것이 맞다고 생각합니다.)

라고 되어있네요.

정리해보면 저는 코드가 간결해야 좋은 코드라고 생각했는데 Fundamentals만 읽었는데도 제 생각이 틀렸다고 생각되네요.. 저 혼자 만들고 평생 유지보수하는 앱에서는 뭐 간결하고 저 혼자만 읽을 수 있는 코드여도 되겠지만? 어쨌든 다른 사람도 읽게 되고 이해를 해야하는 코드에는 꼭 간결하게보다는 명확하게 코드를 작성하고 주석을 달아주는게 좋을 것 같습니다.

## 🎪 Promote Clear Usage
- 여기서부터는 그냥 제가 해석한 내용을 적도록 해보겠습니다
---

#### 필요한 모든 단어들을 포함하라

- 코드를 읽는 사람들을 위해 모호지 않도록 하기 위해!

###### Good

```Swift
extension List {
  public mutating func remove(at position: Index) -> Element
}
employees.remove(at: x) // x번째 인덱스의 employee 제거
```

만약 Method signature에서 `at` 을 생략하면 `x`가 제거할 element의 position(index)가 아닌, x의 값을 가지는 element를 제거하는 메소드로 생각할 수 있다...

###### Bad

```Swift
employees.remove(x) // 명확하지 않다... x를 지우는건지 x 번째 위치의 값을 지우라는건지..?
```

#### 불필요한 단어들을 생략하라

- 이름안에 모든 단어는 사용되는 시점에 중요한 정보를 전달해야 합니다.

###### Bad

```swift
public mutating func removeElement(_ member: Element) -> Element?

allViews.removeElement(cancelButton)
```

위의 경우에는 `Element` 라는 단어를 사용했지만 저 단어가 없어도 명확하게 의미를 이해할 수 있습니다. 이 API를 다시 디자인해보면

###### Good

```swift
public mutating func remove(_ member: Element) -> Element?

allViews.remove(cancelButton) // clearer
```

경우에 따라 모호함을 피하기 위해 타입 정보를 반복하는 것은 필요하지만, 일반적으로 그것의 타입보다는 파라미터의 역할을 설명하는 단어를 사용하는게 더 좋습니다.

#### 타입 제약 조건 대신 역할에 따라 변수, 파라미터, 그리고 연관 타입(associatedtype)의 이름을 지어라

###### 여기서 잠깐! Associated Type이 머죠?

> [Associated Type](https://g4eng.github.io/ios/26) 을 읽어보시면 이해할 수 있으실 겁니다!

###### Bad

```swift
var string = "Hello"
protocol ViewController {
  associatedtype ViewType : View
}
class ProductionLine {
  func restock(from widgetFactory: WidgetFactory)
}
```

이런 식으로 타입 이름을 정의하면 명확하게 표현하는 것이 어려워지니, 엔티티의 역할을 표현하는 이름을 지어라

###### Good

```swift
var greeting = "Hello"
protocol ViewController {
  associatedtype ContentView : View
}
class ProductionLine {
  func restock(from supplier: WidgetFactory)
}
```

만약 연관 타입이 프로토콜 제약에 강하게 연결되어 있어서 프로토콜 이름 자체가 역할을 표현한다면, 충돌을 피하기 위해 프로토콜 이름 마지막에 `Protocol` 을 붙여주자

```swift
protocol Sequence {
  associatedtype Iterator : IteratorProtocol
}
protocol IteratorProtocol { ... }
```

#### 파라미터의 역할을 명확하게 드러내기 위해 불충분한 type 정보를 보충하

- 특히 파라미터 타입이 `NSObject`, `Any`, ` AnyObject`, 혹은 `Int`, `String` 같은 기본 타입일 때, 타입 정보와 사용하는 시점의 문맥이 의도를 완전히 전달하지 못할 수 있다. 아래의 예시를 보면, 정의는 명확하게 되어 있지만, 사용하는 곳에서는 메소드의 의도가 애매하다.

###### Bad

```swift
func add(_ observer: NSObject, for keyPath: String)

grid.add(self, for: graphics) // vague
```

명확하게 하려면, 그것의 역할이 명사로 설명되는 weakly typed parameter를 각각 명시해주세요.

###### Good

```swift
func addObserver(_ observer: NSObject, forKeyPath path: String)
grid.addObserver(self, forKeyPath: graphics) // 명확함
```

## 🗣 Strive for Fluent Usage
- 유창한 사용을 위해 노력하세요
---

#### 메소드와 함수 이름을 영어 문장처럼 사용할 수 있도록 하세요

###### Good

```swift
x.insert(y, at: z)          “x, insert y at z”
x.subViews(havingColor: y)  “x's subviews having color y”
x.capitalizingNouns()       “x, capitalizing nouns”
```

###### Bad

```swift
x.insert(y, position: z)
x.subViews(color: y
x.nounCapitalize()
```

첫번째 또는 두개의 인자 이후에 중요한 인자가 아닌 경우에는 문장적 어색함이 있는 것이 허용됩니다

```swift
AudioUnit.instantiate(
  with: description, 
  options: [.inProcess], completionHandler: stopProgressBar)
```

#### factory methods의 시작은 `make` 로 시작하세요

- e.g  `x.makeIterator()`

#### initializer와 factory method의 호출에서 첫번째 인자의 기본 이름으로 구절을 구성하지 마세요

- e.g `x.makeWidget(cogCount: 47)`

- 예를 들어, 이러한 호출에 대한 첫번째 인자는 기본 이름과 동일한 구문의 일부로 읽혀서는 안됩니다.

###### Good

```swift
let foreground = Color(red: 32, green: 64, blue: 128)
let newPart = factory.makeWidget(gears: 42, spindles: 14)
let ref = Link(target: destination)
```

다음은 API 작성자가 첫번째 인자로 문법적 연속성을 만들기 위해 노력했지만...

###### Bad

```swift
let foreground = Color(havingRGBValuesRed: 32, green: 64, andBlue: 128)
let newPart = factory.makeWidget(havingGearCount: 42, andSpindleCount: 14)
let ref = Link(to: destination)
```

실제로, argument labels에 대한 가이드라인에 따르면, 첫번째 인자는 label을 갖게 된다. (값이 보존되는 타입 변환인 경우는 제외(아래에 있는 예))

```swift
let rgbForeground = RGBColor(cmykForeground)
```

### Side-effect를 기반해서 함수와 메소드의 이름을 지으세요
> Side-effect가 뭔지 모르신다면! [Side-effect에 관해서 with FP](https://g4eng.github.io/ios/3/)
- side-effect가 없는 것은 명사로 읽혀야 한다! eg) `x.distance(to: y)`, `i.successor()`
- side-effect가 있다면 동사로 읽혀야 하고! eg) `print(x)`, `x.sort()`, `x.append(y)`
- mutating / nonmutating 메소드의 이름을 일관성있게 짓기. 주로 mutating 메소드와 함께 비슷한 맥락의 nonmutating 메소드도 만들어 진다. nonmutating method는 인스턴스를 변경하지 않고 새로운 값을 리턴한다.
- operation이 동사로 설명된 경우
  - mutating에는 동사의 명령형을 사용
  - nonmutating에는 "ed" | "ing"를 접미사로 붙여서 사용

|Mutating|Nonmutating|
|---|---|
|`x.sort()`|`z = x.sorted()`|
|`x.append(y)`|`z = x.appending(y)`|

- operation이 명사로 설며오딘 경우
  - nonmutating에는 명사 사용
  - mutating에는 "form" 접두사 붙여서 사용
  
|Nonmutating|Mutating|
|---|---|
|`x = y.union(z)`|`y.formUnion(z)`|
|`j = c.successor(i)`|`c.formSuccessor(&i)`|

### nonmutating 한 변수나 메서드는 호출되는 객체에 대한 주장문처럼 읽혀야 한다
- 리시버와 불리언을 붙여서 쭉 말했을때 일반 문장처럼 들리게 하라
eg. `x.isEmpty`, `line1.intersects(line2)`

### 기능을 설명하는 프로토콜은 able, ible, ing를 사용하는 접미사를 붙여서 이름을 지어야한다
eg. `Equatable`, `ProgressReporting`

### 나머지 타입, 프로퍼티, 변수, 정수는 명사로 읽혀야 한다!

## ✔️ Use Terminology Well
- 용어를 제대로 사용하세요
---

> **Term of Art:** noun - a word or phrase that has a precise, specialized meaning within a particular field or profession.
- 명사 - 특정 필드나 전문 영역에서 정확하고 특별함을 갖는 단어나 구절.

- 일반적인 단어가 의미를 더 잘 전달한다면 **잘 알려져 있지 않은 용어를 쓰지마세요**. “skin”으로 의도를 드러낼 수 있다면 “epidermis”를 쓰지마세요. 전문 용어는 필수적인 대화 수단이지만, 사용하지 않으면 제대로 전달되지 않을 때만 사용해야 합니다.

- 전문 용어를 사용한다면 확립된 의미를 사용하세요. 일반 용어를 사용해서 정확한 의미 전달이 안되는 경우에만, 전문 용어(기술 용어)를 사용해서 정확한 의미를 전달하는 것이 좋습니다. 따라서 API는 이 요어를 허용된 의미에 일치하도록 엄격하게 사용해야 한다.
    - **전문가를 놀라게 하지마세요:** 우리가 전문 용어에 새로운 의미를 부여한다면 용어에 익숙한 전문가들은 놀라게 될 겁니다!
    - **초급자를 혼란스럽게 하지마세요:** 이 용어를 배우려는 사람이 인터넷에 검색했을 때 전통적인 의미가 나올 수 있습니다.

- **약어(줄임말, abbreviations) 사용을 피하세요.** 정형화 되어있지 않은 약어를 이해하려면, 다시 풀어서 해석해야 하기 때문에 전문 용어(terms of art, 아는 사람만 아는 것)라고 볼 수 있다.

> 사용된 약어의 의도된 의미 또한 인터넷 검색으로 쉽게 찾을 수 있어야 한다!

- **관례를 따르세요.** 기존 문화와 다른 용어를 사용하면서까지 초심자를 배려하지 않아도 됩니다. 
연속된 데이터 구조를 표현할 때, 비록 초심자가 `List` 를 쉽게 이해한다고 해도 `List` 보다는 `Array`로 용어를 사용하는게 낫습니다. `Array`는 현대 컴퓨팅의 기초기 때문에 모든 프로그래머들이 알고 있거나 곧 알게될거기 때문에 용어를 사용할 때 프로그래머들에게 친숙한 용어를 사용하세요. 그러면 그들이 웹 검색이나 질문을 할 때 답변을 찾을 수 있을 것입니다.

수학같은 특정 프로그래밍 도메인에서, `sin(x)` 같은 광범위하게 사용되는 용어는 그대로 사용하는 것이 `verticalPositionOnUnitCircleAtOriginOfEndOfRadiusWithAngle(x)` 같은 네이밍보다는 (훨씬) 낫습니다. 이 경우 약어를 피하는 것보다 관례를 따르는 것에 더 가중치가 있다는 것에 주목하세요. 비록 온전한 단어는 sine이지만 `sin(x)`는 프로그래머, 수학자들에게는 오랫동안 보편적으로 사용되어 왔기 때문입니다.
