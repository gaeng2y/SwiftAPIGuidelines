# Swift API Design Guidelines

iOS Developer 오픈 카톡을 보다가 어떤 한 분이 (Swift API Design Guidelines)[https://www.swift.org/documentation/api-design-guidelines/] 내용을 잘 정리해주신 강의를 만들었다고 올려주셔서 구매해서 듣게되었는데...

나는 지금까지 기계처럼 일하고 공부하기만 했구나라는 생각이 들게되었던 하루다... 

앞으로는 최신 기술 / 지식만 쌓는게 아니라 어떻게 해야 더 좋은 코드가 될지 고민하고 또 고민하는 개발자가 되어야겠다고 생각하며 공부했던 내용을 정리해보겠습니다...

### Fundamentals

우선 Swift API Design Guidelines 에 있는 내용을 토대로 정리해보겠습니다...

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

### Promote Clear Usage

- 여기서부터는 그냥 제가 해석한 내용을 적도록 해보겠습니다

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