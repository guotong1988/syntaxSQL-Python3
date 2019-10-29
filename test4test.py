import torch
input_tensor = torch.tensor([1,2,3,4,5])
print(input_tensor.index_select(0,torch.tensor([0,2,4])))

input_tensor = torch.tensor([[1,2,3,4,5],[6,7,8,9,10]])
print(input_tensor.index_select(0,torch.tensor([1])))
print(input_tensor.index_select(1,torch.tensor([1])))
