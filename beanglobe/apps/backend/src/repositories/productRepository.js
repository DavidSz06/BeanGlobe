// REPOSITORY (only layer that touches the DB): The ONLY place that runs SQL for products. Reads products.type and joins coffee_details OR machine_details, returning ONE coherent object. Nothing above knows there are two detail tables.
//
// TODO: build Socratically.
