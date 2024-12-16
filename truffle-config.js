module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",  // Localhost
      port: 8545,          // Ganache default port
      network_id: "1342",     // Match any network
      gas: 6721975,        // Increase gas limit if needed
      gasPrice: 20000000000, // Adjust the gas price if necessary
    },
  },
  compilers: {
    solc: {
      version: "0.8.19",  // Make sure this matches your contract's pragma initial=[0.8.0] version   initial=[^0.8.21] 
    },
  },
};
