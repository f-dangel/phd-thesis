"""Example: Training Loop using Cockpit."""

import torch
from _utils_examples import cnn, fmnist_data, get_logpath
from backpack import extend
from cockpit import Cockpit, CockpitPlotter
from cockpit.utils.configuration import configuration as config

fmnist_data = fmnist_data()
model = extend(cnn())
loss_fn = extend(torch.nn.CrossEntropyLoss(reduction="mean"))
losses_fn = torch.nn.CrossEntropyLoss(reduction="none")
opt = torch.optim.SGD(model.parameters(), lr=1e-2)

cockpit = Cockpit(model.parameters(), quantities=config("full"))
plotter = CockpitPlotter()

max_steps, global_step = 50, 0
for inputs, labels in iter(fmnist_data):
    opt.zero_grad()

    outputs = model(inputs)
    loss = loss_fn(outputs, labels)
    losses = losses_fn(outputs, labels)

    with cockpit(
        global_step,
        info={
            "batch_size": inputs.shape[0],
            "individual_losses": losses,
            "loss": loss,
            "optimizer": opt,
        },
    ):
        loss.backward(
            create_graph=cockpit.create_graph(global_step),
        )

    opt.step()
    global_step += 1

    if global_step >= max_steps:
        break

cockpit.write(get_logpath())
plotter.plot(get_logpath())
