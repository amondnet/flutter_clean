/// Status of a resource that is provided to the UI.
///
/// These are usually created by the Repository classes where they return
/// `Observable<Resource<T>>` to pass back the latest data to the UI with its fetch status.
enum Status { SUCCESS, ERROR, LOADING }
