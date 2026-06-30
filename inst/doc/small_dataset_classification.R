params <-
list(eval = TRUE)

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(LBBNN)
has_torch <- requireNamespace("torch", quietly = TRUE) &&
            torch::torch_is_installed()

## ----eval = has_torch---------------------------------------------------------
torch::torch_manual_seed(42)
loaders_gs <- get_dataloaders(gallstone_dataset, train_proportion = 0.70,
                              train_batch_size = 223, test_batch_size = 96,
                              standardize = TRUE, seed = 42)
train_loader_gs <- loaders_gs$train_loader
test_loader_gs <- loaders_gs$test_loader

## ----eval = has_torch---------------------------------------------------------
problem <- "binary classification"
sizes <- c(40, 16, 16, 16, 16, 1)
inclusion_priors <- c(0.5, 0.5, 0.5, 0.5, 0.5) 
stds <- c(1, 1, 1, 1, 1) 
inclusion_inits <- 'polarized_dense'
device <- "cpu"
model_gs <- lbbnn_net(problem_type = problem, sizes = sizes,
                     prior = inclusion_priors, flow = TRUE,
                     dims = c(10, 10, 10, 10), 
                     inclusion_inits = inclusion_inits,
                     input_skip = TRUE, std = stds, device = device)
#print(model_gs)

## ----eval = FALSE-------------------------------------------------------------
# train_lbbnn(epochs = 1000, LBBNN = model_gs,
#             lr = 0.005, train_dl = train_loader_gs, device = device,
#             verbose = FALSE)
# 
# validate_lbbnn(LBBNN = model_gs, num_samples = 10, test_dl = test_loader_gs,
#               device = device)
# 

## ----eval = FALSE-------------------------------------------------------------
# torch::torch_manual_seed(42)
# model_2 <- lbbnn_net(problem_type = problem, sizes = sizes,
#                      prior = inclusion_priors, flow = TRUE,
#                      dims = c(10, 10, 10, 10),
#                      inclusion_inits = inclusion_inits,
#                      input_skip = TRUE, std = stds, device = device)
# 
# train_lbbnn(epochs = 1000, LBBNN = model_2,
#             lr = 0.005, train_dl = train_loader_gs, device = device,
#             verbose = FALSE, min_density = 0.1)
# 
# validate_lbbnn(LBBNN = model_2, num_samples = 10, test_dl = test_loader_gs,
#               device = device)

