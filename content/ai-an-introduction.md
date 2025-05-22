+++
title = "AI: An Introduction"
date = 2025-05-11
+++

* [definitions](#definitions)
* [architecture](#architecture)
* [problem-framing](#problem-framing)
* [reinforcement-learning](#reinforcement-learning)

# About 
This page is an attempt to provide an overview of the highly dynamic world of AI.

Beyond today’s popular foundation models, it’s fascinating to see how AI evolves over time.

Soon, instead of building models from scratch, we might rely more on pre-trained systems. The bigger question will be: How do we integrate AI into traditional software? Standards like MCP - Model Context Protocol or A2A (Agent2Agent protocol)  could play a key role here.

As always the case when program a computer we should ask us: __which problem I want to solve__?

# Definitions
* Architecture: The blueprint of the neural network (e.g., CNN, Transformer).
* Model: A trained instance of an architecture (e.g., "ResNet-50" is a CNN model).
* Frameworks: Scikit-learn (classic ML), Tensorflow/PyTorch (Deep Learning)
* Basic ML workflow
```
ingest data → feature engineering → train model → predict
```

# Architecture

Network architectures are like _design pattern_ in software development. 

* Images (e.g., classification, object detection)
  * Architecture: CNN (Convolutional Neural Network)
  * Examples: ResNet, EfficientNet, VGG.
* Text/Language (e.g., translation, sentiment analysis)
  * Architecture: Transformer
  * Examples: BERT (understanding), GPT (generation).
  * https://daleonai.com/transformers-explained
* Time Series (e.g., forecasting, sensor data)
  * Architecture: LSTM or Transformer
* Generative Tasks (e.g., image/text creation)
  * GAN (Generative Adversarial Network)
    * Examples: StyleGAN (images), Deepfake videos.
  * Diffusion Models
    * Examples: Stable Diffusion (images), DALL-E.

# Problem-Framing 
How to determine if machine learning (ML) is a good approach for a problem.
* https://developers.google.com/machine-learning/problem-framing

# heuristic
A simple and quickly implemented solution to a problem. For example, "With a heuristic, we achieved 86% accuracy. When we switched to a deep neural network, accuracy went up to 98%."
* https://developers.google.com/machine-learning/glossary#heuristic

# TODO 
> Machine learning workflows are often composed of different parts. A typical pipeline consists of a pre-processing step that transforms or imputes the data, and a final predictor that predicts target values.
* https://scikit-learn.org/stable/getting_started.html#transformers-and-pre-processors

# LLM-as-a-Judge
LLM-as-a-Judge is the process of using LLMs to evaluate model outputs.

# invariance testing
TODO 

# holdout 
TODO 

# Hyperparameter tuning
Hyperparameters, such as learning rate, batch size, and epochs, are external configurations that influence the training process of a machine learning model.

# backtesting

# 5-fold cross-validation
In short: validate your model.

5-fold CV is the gold standard for model evaluation when you want balance between reliability and computational cost.

A robust evaluation technique in machine learning where the dataset is split into 5 equal parts (folds). The model is trained on 4 folds and validated on the remaining 1 fold, repeating this process 5 times (each fold serves as the validation set once).

Why use it? 
* Reduces overfitting – Tests model performance across different data subsets.
* Maximizes data usage – Every data point is used for both training and validation.
```python 
from sklearn.model_selection import cross_val_score
from sklearn.ensemble import RandomForestClassifier

model = RandomForestClassifier()
scores = cross_val_score(model, X, y, cv=5)  # 5-fold CV
print(f"Mean Accuracy: {scores.mean():.2f} (±{scores.std():.2f})")
```

* https://scikit-learn.org/stable/getting_started.html#model-evaluation

# Binning 
Binning (also called bucketing) is a feature engineering technique.
* https://developers.google.com/machine-learning/crash-course/numerical-data/binning

# Simpson's paradox
TODO 

# z-score 
TODO 

# Baseline 
A simple reference model to compare against more complex solutions.
In short; check if your model is better then a trivial approaches.

## Random Baseline 
A type of baseline that makes random predictions within the possible output range.

## zero-baseline (zero-rule)
The simplest possible baseline that always predicts the most common class or average value.


# Feature Engineering

Is the task to bring the _raw data_ into numerical data format as input for the model. Usually you read that a data analyst (previously data scientist) does this task.

It's not a role, it's a task. I would also say that prompt engineering is _only_ a task.

A role is more ML engineering or AI engineering.

# supervised/unsupervised Learning 
* static data

## supervised learning
* use-case: labeled data available (input → output pairs).

## unsupervised learning
* use-case: no labels, find hidden patterns.

# Reinforcement Learning 
* interactive environments
* use-case: sequential decision-making (actions → rewards).

# Deep Learning 
* scalable for high-dimensional data
* use-case: complex data (images, text, time series).

# Random Forest 
Random Forest is a classical (non-deep) machine learning algorithm.
It’s an ensemble method (combines multiple decision trees) for supervised learning.

```python 
from sklearn.ensemble import RandomForestClassifier
model = RandomForestClassifier()
model.fit(X_train, y_train)  # Works on tabular data!
```

# Decision Trees 
Decision Trees are simple, interpretable models for classification/regression that split data hierarchically (like a flowchart). Random Forest improves them by combining many trees (ensemble) to reduce overfitting and boost accuracy.

# Neural Network
There are supervised learning neural network models and unsupervised learning neural network models.

# GAN - Generative Adversarial Network
* use-case: image generation 

# CNN - Convolutional Neural Network
* use-case: object-detection 
* typical CNN flow
```
Input → [Conv → ReLU → Pooling] × N → FC → Output
```

# RNN - Recurrent Neural Networks
RNNs (Recurrent Neural Networks) are used for sequential data (like text, time series, or speech) where order matters. They process inputs step-by-step while maintaining a "memory" of previous steps.

Largely replaced by Transformers for most tasks today, but still relevant for simple sequences or low-resource settings.

# Stable Diffusion

Stable Diffusion is a deep learning, text-to-image model based on diffusion techniques.
A method that combines:
* U-Net (CNN architecture for image generation).
  * A convolutional neural network (CNN) used for iterative image denoising.
* Text-encoder (Transformer-based architecture for text understanding).
  * Converts text into numerical tokens → mapped to embedding vectors.
* https://mccormickml.com/2022/12/21/how-stable-diffusion-works/

## Simplified Flow 
```
Text Prompt → Text-Encoder (Transformer) → Diffusion Process (U-Net) → Generated Image
```

#  Sources
* Me (& books)
* Wikipedia
* https://developers.google.com/machine-learning/glossary/fundamentals
* https://a16z.com/ai-canon/
* _INFO: some text is AI generated_

