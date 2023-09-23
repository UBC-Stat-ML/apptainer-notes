Image for BlangSDK 2.18.3: https://github.com/UBC-Stat-ML/blangSDK

For example, to run non-reversible parallel tempering on an Ising model and produce various plots: 

```
docker run -w /tmp -v $(pwd):/tmp alexandrebouchardcote/blang:0.0.0 --model blang.validation.internals.fixtures.Ising --postProcessor DefaultPostProcessor
```

The results will be available in `results/latest` of the current directory.