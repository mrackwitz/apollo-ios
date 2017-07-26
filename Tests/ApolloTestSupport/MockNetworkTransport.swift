import Apollo
import Dispatch

public final class MockNetworkTransport: NetworkTransport {
  let body: JSONObject

  public init(body: JSONObject) {
    self.body = body
  }

  public func send<Operation>(operation: Operation, completionHandler: @escaping (_ response: GraphQLResponse<Operation>?, _ error: Error?) -> Void) -> Cancellable {
    DispatchQueue.global(qos: .default).async {
      completionHandler(GraphQLResponse(operation: operation, body: self.body), nil)
    }
    return MockTask()
  }
    
  public func upload<Operation: GraphQLOperation>(operation: Operation, files: [GraphQLFile]? = nil, progressHandler: ((Apollo.Progress) -> Void)? = nil, completionHandler: @escaping (GraphQLResponse<Operation>?, Error?) -> Void) -> Cancellable {
    return MockTask()
  }
}

private final class MockTask: Cancellable {
  func cancel() {
  }
}
