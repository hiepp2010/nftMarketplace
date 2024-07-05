const minTonForStorage: Int = ton("0.03");
const gasConsumption: Int = ton("0.03");

message CreateCollection{
    collectionContent: String;
}

message MintCollection{
    nftCollectionIndex: Int as unit32;
    nftItemContent: String;
    
}