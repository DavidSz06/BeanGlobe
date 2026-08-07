// ADAPTER INTERFACE: free-text tasting notes -> structured flavor vector.
//   parse(notesText) -> flavorVector
// Keeps the choice of Haiku vs Gemini swappable, and the LLM at arm's length
// from the domain (matchingService consumes the vector, not the LLM).
//
// TODO: build Socratically. (Concrete Haiku/Gemini impl added later.)
