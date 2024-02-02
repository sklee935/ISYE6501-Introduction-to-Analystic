import pandas as pd
import matplotlib.pyplot as plt

# Sample data representing the accuracy scores for each value of K
# This data should be replaced with the actual results from the R output
data = {
    'k': [5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 41, 43],
    'Accuracy': [
        0.8396154, 0.8269231, 0.8267949, 0.8267949, 0.8369231, 0.8370513,
        0.8448077, 0.8473077, 0.8524359, 0.8473077, 0.8421795, 0.8396795,
        0.8345513, 0.8371154, 0.8371154, 0.8421795, 0.8473077, 0.8447436,
        0.8447436, 0.8421154
    ]
}

# Create a DataFrame
df = pd.DataFrame(data)

# Plot
plt.figure(figsize=(10, 6))
plt.plot(df['k'], df['Accuracy'], marker='o', linestyle='-')
plt.title('Model Accuracy for Different Values of k')
plt.xlabel('Number of Neighbors: k')
plt.ylabel('Accuracy')
plt.grid(True)
plt.xticks(df['k'])  # Set x-ticks to be every k value
plt.tight_layout()
plt.show()
