#[starknet::interface]
trait IHelloStarknet<TContractState> {
    fn donate(ref self: ContractState, amount: u128)
    fn get_balance(self: @TContractState) -> felt252;
}


#[storage]
struct Storage {
    donations: LegacyMap<ContractAddress, u128>,
    total_donations: u128,
}

#[derive(Drop, Serde, starknet::Store)]
pub struct Donor {
    address: ContractAddress,
    name: felt252,
    amount_donated: u128,
}
#[event]
#[derive(Drop, starknet::Event)]
struct DonationReceived {
    #[key]
    donor: ContractAddress,
    amount: u128,
}
#[abi(embed_v0)]
impl DonationContract of super::IDonationContract<ContractState> {
    fn donate(ref self: ContractState, amount: u128) {
        let donor = get_caller_address();
        let current_amount = self.donations.read(donor);
        self.donations.write(donor, current_amount + amount);
        self.total_donations.write(self.total_donations.read() + amount);
        self.emit(DonationReceived { donor: donor, amount: amount });
    }
}
#[constructor]
fn constructor(ref self: ContractState) {
    self.total_donations.write(0);
}
