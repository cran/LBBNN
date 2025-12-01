params <-
list(eval = FALSE)

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = params$eval
)

## -----------------------------------------------------------------------------
# library(LBBNN)
# library(ggplot2)
# library(torch)

## -----------------------------------------------------------------------------
# loaders <- get_dataloaders(Raisin_Dataset, train_proportion = 0.8,
#                            train_batch_size = 720, test_batch_size = 180)
# train_loader <- loaders$train_loader
# test_loader  <- loaders$test_loader

## -----------------------------------------------------------------------------
# problem <- 'binary classification'
# sizes <- c(7,5,5,1)
# inclusion_priors <- c(0.5,0.5,0.5)
# stds <- c(1,1,1)
# inclusion_inits <- matrix(rep(c(-10,15),3), nrow = 2, ncol = 3)
# device <- 'cpu'
# 
# torch_manual_seed(0)
# model_input_skip <- LBBNN_Net(problem_type = problem, sizes = sizes, prior = inclusion_priors,
#                               inclusion_inits = inclusion_inits, input_skip = TRUE, std = stds,
#                               flow = FALSE, device = device)

## -----------------------------------------------------------------------------
# results_input_skip <- train_LBBNN(epochs = 50, LBBNN = model_input_skip,
#                                   lr = 0.005, train_dl = train_loader, device = device)

## -----------------------------------------------------------------------------
# validate_LBBNN(LBBNN = model_input_skip, num_samples = 100,
#                test_dl = test_loader, device = device)

## -----------------------------------------------------------------------------
# LBBNN_plot(model_input_skip, layer_spacing = 1, neuron_spacing = 1,
#            vertex_size = 15, edge_width = 0.5)
# 
# x <- torch::dataloader_next(torch::dataloader_make_iter(train_loader))[[1]]
# inds <- sample.int(dim(x)[1], 1)
# data <- x[inds,]
# plot_local_explanations_gradient(model_input_skip, data, num_samples = 100, device = device)

