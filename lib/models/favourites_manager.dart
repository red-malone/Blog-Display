class FavoriteManager {
  final Set<String> favoriteBlogIds = {};
  // Add a blog to favorites
  void addToFavorites(String blogId) {
    favoriteBlogIds.add(blogId);
  }

  // Remove a blog from favorites
  void removeFromFavorites(String blogId) {
    favoriteBlogIds.remove(blogId);
  }

  // Check if a blog is in favorites
  bool isFavorite(String blogId) {
    return favoriteBlogIds.contains(blogId);
  }
}
