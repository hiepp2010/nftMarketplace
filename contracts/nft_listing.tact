import "@stdlib/deploy";
import "@stdlib/ownable";

contract NftListing with Deployable, Ownable{
    owner: Address; 
    marketplaceFee: Int as unit32;
    royaltyFee: Int as unit 32;
    expiredDate: Int as unit32;
    ownerNftAddress: Address;
    expectedPrice: Int as unit32;

    init(owner: Address)
} 