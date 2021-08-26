/// Common class used by API responses.
class ApiResponse<T> {}

class ApiErrorResponse<T> extends ApiResponse<T> {
  final String errorMessage;

  ApiErrorResponse(this.errorMessage);
}

class ApiEmptyResponse<T> extends ApiResponse<T> {}

class ApiSuccessResponse<T> extends ApiResponse<T> {
  final T data;

  ApiSuccessResponse(this.data);
}
