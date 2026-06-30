params <-
list(eval = TRUE)

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(LBBNN)
has_torch <- requireNamespace("torch", quietly = TRUE) &&
            torch::torch_is_installed()

## ----eval = has_torch---------------------------------------------------------
torch::torch_manual_seed(42)
loaders <- get_dataloaders(raisin_dataset, train_proportion = 0.8,
                           train_batch_size = 720, test_batch_size = 180)
train_loader <- loaders$train_loader
test_loader  <- loaders$test_loader

## ----eval = has_torch---------------------------------------------------------
problem <- "binary classification"
sizes <- c(7, 5, 5, 1)
inclusion_priors <- c(0.5, 0.5, 0.5)
stds <- c(1, 1, 1)
inclusion_inits <- 'balanced'
device <- "cpu"
model <- lbbnn_net(problem_type = problem, sizes = sizes,
                   prior = inclusion_priors,
                   inclusion_inits = inclusion_inits,
                   input_skip = TRUE, std = stds,
                   flow = FALSE, device = device)

## ----eval = has_torch---------------------------------------------------------
train_lbbnn(epochs = 10, LBBNN = model,
            lr = 0.05, train_dl = train_loader,
            device = device, verbose = FALSE)

## ----eval = has_torch---------------------------------------------------------
validate_lbbnn(LBBNN = model, num_samples = 2,
               test_dl = test_loader, device = device)

## ----fig.width=6, fig.height=6, eval = has_torch------------------------------
plot(model, type = 'global', vertex_size = 10, edge_width = 0.6, label_size = 0.6)

## ----fig.width=6, fig.height=6, eval = has_torch------------------------------
x_data <- train_loader$dataset$tensors[[1]] 
data <- x_data[42, ]
plot(model, type = "local", data = data,num_samples = 10)

## ----eval = has_torch---------------------------------------------------------
print(coef(model, data,num_samples = 10))

