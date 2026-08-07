// ADAPTER INTERFACE / CONTRACT.
// The shape every price source must implement, e.g.:
//   getPrices(productId) -> [{ source, price, currency, url, updatedAt }]
// Services depend on THIS shape, not on eMAG/2Performant specifics.
//
// TODO: build Socratically.
