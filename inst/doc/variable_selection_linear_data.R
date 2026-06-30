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
i <- 1000
j <- 15
set.seed(42)
torch::torch_manual_seed(42)
X <- matrix(rnorm(i * j, mean = 0, sd = 1), ncol = j)
y_base <- c()
y_base <-  0.6 * X[, 1] - 0.4 * X[, 2] + 0.5 * X[, 3] + rnorm(n = i, sd = 0.1)
sim_data <- as.data.frame(X)
sim_data <- cbind(sim_data, y_base)
loaders <- get_dataloaders(sim_data, train_proportion = 0.9,
                           train_batch_size = 450, test_batch_size = 100,
                           standardize = FALSE)
train_loader <- loaders$train_loader
test_loader  <- loaders$test_loader

## ----eval = has_torch---------------------------------------------------------
problem <- "regression"
sizes <- c(j, 5, 5, 1) 
incl_priors <- c(0.5, 0.5, 0.5) 
stds <- c(1, 1, 1)
incl_inits <- 'polarized'
device <- "cpu" 
model_linear <- lbbnn_net(problem_type = problem, sizes = sizes,
                              prior = incl_priors, inclusion_inits = incl_inits,
                              std = stds, input_skip = TRUE, flow = FALSE,
                              num_transforms = 2, dims = c(10, 10, 10),
                              raw_output = FALSE, custom_act = NULL,
                              link = NULL, nll = NULL,
                              bias_inclusion_prob = FALSE, device = device)

## ----eval = has_torch---------------------------------------------------------
train_lbbnn(epochs = 50, LBBNN = model_linear,
            lr = 0.1, train_dl = train_loader, device = device, verbose = FALSE)
validate_lbbnn(LBBNN = model_linear, num_samples = 2, test_dl = test_loader,
              device = device)

## ----eval = has_torch---------------------------------------------------------
coef(model_linear, dataset = train_loader, inds = NULL,
     output_neuron = 1, num_data = 5, num_samples = 10)

## ----fig.width=6, fig.height=6, eval = has_torch------------------------------
plot(model_linear, type = "global", vertex_size = 7,
     edge_width = 0.4, label_size = 0.4)

